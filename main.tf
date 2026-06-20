variable "aws_region" {
  description = "AWS region to deploy resources in."
  type        = string
  default     = "us-west-2"
}

resource "random_string" "random_suffix" {
  length  = 4
  upper   = false
  numeric = true
  special = false
}

resource "aws_s3_bucket" "example" {
  bucket = "terraform-mcp-demo-bucket-${random_string.random_suffix.result}"
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.example.bucket
  key    = "test_s3_object"
  source = "test.txt"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("test.txt")
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# VPC Configuration
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "terraform-mcp-demo-vpc-${random_string.random_suffix.result}"
    Environment = "demo"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "terraform-mcp-public-subnet-${count.index + 1}-${random_string.random_suffix.result}"
    Environment = "demo"
    Type        = "public"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 10}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "terraform-mcp-private-subnet-${count.index + 1}-${random_string.random_suffix.result}"
    Environment = "demo"
    Type        = "private"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "terraform-mcp-igw-${random_string.random_suffix.result}"
    Environment = "demo"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "terraform-mcp-nat-eip-${random_string.random_suffix.result}"
    Environment = "demo"
  }

  depends_on = [aws_internet_gateway.main]
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name        = "terraform-mcp-nat-gateway-${random_string.random_suffix.result}"
    Environment = "demo"
  }

  depends_on = [aws_internet_gateway.main]
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "terraform-mcp-public-rt-${random_string.random_suffix.result}"
    Environment = "demo"
  }
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name        = "terraform-mcp-private-rt-${random_string.random_suffix.result}"
    Environment = "demo"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Data source to get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Get AMI ID from HashiCorp Security
data "aws_ami" "hc-base-ubuntu-2404" {
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  most_recent = true
  owners      = ["099720109477"] # ami-prod account
}

# Security Group for EC2 instance
resource "aws_security_group" "ec2_security_group" {
  name_prefix = "terraform-mcp-ec2-sg-${random_string.random_suffix.result}"
  vpc_id      = aws_vpc.main.id

  # HTTP access
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "terraform-mcp-ec2-sg-${random_string.random_suffix.result}"
    Environment = "demo"
  }
}

# EC2 Instance in Public Subnet
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.hc-base-ubuntu-2404["amd64"].id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  subnet_id              = aws_subnet.public[0].id

  # User data script to install and start Apache
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Jenna's EC2 Instance!</h1>" > /var/www/html/index.html
              echo "<p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>" >> /var/www/html/index.html
              echo "<p>Availability Zone: $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>" >> /var/www/html/index.html
              EOF

  tags = {
    Name        = "terraform-mcp-web-server-${random_string.random_suffix.result}"
    Environment = "demo"
    Type        = "web-server"
  }
}

# Elastic IP for the EC2 instance (optional)
resource "aws_eip" "ec2_eip" {
  instance = aws_instance.web_server.id
  domain   = "vpc"

  tags = {
    Name        = "terraform-mcp-ec2-eip-${random_string.random_suffix.result}"
    Environment = "demo"
  }

  depends_on = [aws_internet_gateway.main]
}
