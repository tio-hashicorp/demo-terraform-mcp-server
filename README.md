# DDR Demo: Terraform - Terraform MCP Server + Agent Skills

## Demo Prerequisites

<!-- If there are more than the below prerequisites, please put them in a numbered list format -->
<!-- Prerequisites should include an information that needs to be performed BEFORE the no-code module is provisioned. This includes steps/settings you want them to configure for the no-code module itself. -->

> **NOTE**: because of the nature of using the MCP server and Agent Skills with an AI coding assistant, **majority of this demo will be shown from your local machine** with resources provided from this demo module. This means there are more demo prerequisites you must go through prior to showcasing the demo.


1. [Install VScode](https://code.visualstudio.com/download) locally with the Copilot Chat extension and MCP support enabled:
    - Install the [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat) extension in your local VScode.
    - Enable MCP support:
        - Open settings with `Cmd` + `,`.
        - In the search bar, type **mcp**.
        - Look for **Chat > MCP > Gallery: Enabled** and check this box.

1. After downloading VScode and upgrading your GitHub account to have Enterprise Copilot features, login to GitHub in VScode:
    - Click the user icon in the bottom left of VScode then **Sign in to Sync Settings**.
    - Authorize your HashiCorp associated GitHub account to sign in.

1. Confirm you can use the GitHub Copilot Chat within VScode:
    - Ensure you're using Agent mode.
    - Choose an LLM of your choice, we recommend GPT-5.3-Codex.
    - Prompt the agent with something simple like "can I use copilot chat?"

1. Install the Git CLI. Instructions found [here](https://git-scm.com/install/).

    > **NOTE:** you will be performing CLI driven runs on a workspace in your DDR project. There is no need to connect the below repo via VCS connection.

1. Install the Terraform CLI. Instructions found [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform)

1. Clone the [demo-terraform-terraform-mcp-server](https://github.com/tio-hashicorp/demo-terraform-terraform-mcp-server) repository to your local machine and open in VScode to showcase updating code with the Terraform MCP server and Agent Skills.
    - [Docs](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) on how to clone a repository.
    - Edit the `terraform.tf` file on your local machine to update the workspace `name` and `project`.
        - Choose a workpace `name` of your choice - keep in mind your workspace name must be unique org-wide!
        - The `project` name should be either your **`hc-<username>`** or **`ibm-<username>`** DDR project name.

## Demo Provision Time

<!-- Goal should be to keep this under 5 minutes whenever possible. -->

This demo should take about **1-3 minutes** to provision.

## Field Resources

### The Pain

<!-- Describe the pain point that this demo addresses, and how the feature being presented solves this pain. This should be a high-level overview. -->

Despite Infrastructure as Code promising to streamline cloud resource management, today's workflows remain fragmented and error-prone. Developers bounce between CLIs and the registry while researching Terraform modules and provider documentation, leading to misconfigurations and painful onboarding. Meanwhile, Copilot usage within enterprises is growing, signaling developers' desire for conversational infrastructure tools.

The need is clear: "When provisioning cloud infrastructure, I need help writing and validating IaC quickly and confidently without context switching, so I can stay in move faster, reduce errors, and stay in flow."

### The Solution

The emerging ecosystem of AI assistants like GitHub Copilot presents a significant market opportunity for MCP servers. By connecting HCP Terraform's data and workflows directly to these platforms, HashiCorp can offer developers a first-party experience that streamlines infrastructure code generation, validation, and deployment, addressing the growing demand for easily accessible and accurate conversational infrastructure tools.

The Terraform MCP server enables AI models to securely connect with Terraform to query the registry for provider, module, and policy information and request recommendations. It offers several key benefits:

- **Real-time accuracy**: Access current provider documentation instead of relying on potentially outdated training data.
- **Terraform Registry integration**: Direct integration with public Terraform Registry APIs for providers, modules, and policies.
- **HCP Terraform and Terraform Enterprise support**: Full workspace management, organization/project listing, and private registry access.
- **Workspace operations**: create, update, delete workspaces with support for variables, tags, and run management.
- **AI enhancement**: Enables more accurate and actionable Terraform configuration generation.

### Demo Recording

<!-- If the demo recording is available, use the below text:
[Here](<INSERT_LINK>) is a "golden" recording of this demo - meaning it is the recommended workflow for running this demo. Please use this as a *reference point* for how you run the demo. **This video is NOT meant to be used in lieu of a live demo.**
-->

<!-- If the demo recording is NOT available, use the below text:-->
COMING SOON!

### Slide Deck

<!-- A link to an existing slide deck in Highspot, Google Slides, etc. -->

<!-- You should create a slide deck for this demo in [this Google Drive](https://drive.google.com/drive/folders/1_ftoMjYyZQYj_aeyFK2w351IYzHAeyHL?usp=drive_link) for the specific demo and link it here:
You can use this [Demo Slide Deck](<LINK>) as the presentation portion of your demo. Feel free to make a copy of the deck to customize the deck or add/remove any slides.
-->

<!-- If the demo concept is covered in the product tech deck from HighSpot, link directly to the slides covering that feature here:
There are also slides in the [FY25 <PRODUCT> Tech Deck](<TECH DECK LINK>) if you want to pick and choose slides from there.
-->

You can use this technical motion deck over [Modernizing Terraform AI Driven Infrastructure](https://ibm.sharepoint.com/:p:/s/DEPT-WWTFOAdvancedArchitecture/IQBTDUwD5dPgRqCPUe0-VSy_AXah-QN1hpq5tKTLWfXg0GQ?e=bbS3x2&wdOrigin=TEAMS-MAGLEV.null_ns.rwc&wdExp=TEAMS-TREATMENT&wdhostclicktime=1772563066108&web=1) as the presentation portion of your demo.

### Additional Resources

<!-- Any additional resources that may be helpful for the audience to review before or after the demo. -->

- Terraform MCP server [repo](https://github.com/hashicorp/terraform-mcp-server)
- Terraform MCP server [docs](https://developer.hashicorp.com/terraform/mcp-server)
- HashiCorp Agent Skills [repo](https://github.com/hashicorp/agent-skills)
- HashiCorp Agent Skills [blog](https://www.hashicorp.com/en/blog/introducing-hashicorp-agent-skills)
- Agent Skills for greenfield module creation [repo](https://github.com/hashicorp-sa/terraform-agent-skills)

## Run the Demo

The demo will host a Terraform MCP server for you on an EC2 instance; providing your `TFE_TOKEN` for authentication as part of the demo deployment. Prior to going through the demo but after deploying the no-code module, you will need to connect the MCP server to your local VScode. To do so, follow these steps:

1. Within VScode, open the Command Palette.
    - For macOS: `Cmd` + `Shift` + `P`
    - For Windows/Linux: `Ctrl` + `Shift` + `P`
1. Type "`MCP: Open User Configuration`"
1. Add the following to your `servers` block, where `mcp_terraform_server_url` is found in the **Outputs** section of your no-code provisioned workspace:

    ``` 
    {
    "servers": {
        "terraform": {
            "command": "/usr/local/bin/terraform-mcp-server",
            "args": []
        }
    }
    }
    ```

1. Click the `Start` button below the `servers` block to initiate the MCP server.

### Key Takeaways

<!-- List the key takeaways that you want the audience to remember after the demo. -->
Convey the following points to the customer:

- **AI becomes infrastructure-aware** when connected to real-time Terraform data via the MCP Server
- **Organization standards can be enforced** through Agent Skills and private module registries  
- **New modules can be generated from plain-English descriptions** — specification first, code second, documentation included
- **Developer experience improves dramatically** with conversational infrastructure workflows that don't require leaving the IDE
- **Platform teams scale without scaling headcount** by encoding best practices into skills that any developer can invoke

<!-- Insert key concepts here in bullet point format -->

### Talk Track and Instructions

<!-- Provide a detailed talk track and instructions for the demo. Include any gotchas and other steps  -->

> NOTE: This demo can be run in two different use cases: "**Refactor existing Terraform code**" and "**Generate a Terraform module from scratch**". The first use case shows how the MCP Server and Agent Skills can take messy, non-standard Terraform and bring it up to organizational standards using the private module registry. The second use case demonstrates generating a brand-new, registry-ready Terraform module from a plain-English description using the Specify + Generate workflow. You can choose to run either one or both use cases based on your audience and their particular needs.

1. Introduction
    - Talk Track: "Welcome everyone. Today we're going to explore something that I think will fundamentally change how you think about writing infrastructure code. We'll be covering how you can modernize Terraform with AI driven infrastructure by leveraging agentic workflows. I'm sure many of you have been frustrated when Copilot suggests Terraform code that doesn't match your organization's standards, or references modules that don't exist in your registry, or is just... outdated. This is the disconnect we're solving today. What if your AI assistant actually knew about your infrastructure? Your private modules, your standards, and your policies? What if you could have a conversation with Terraform itself? That's what we've built with the Terraform MCP Server and Agent Skills."

<details>
<summary>Use Case 1: Refactor existing Terraform code (Click to expand)</summary>

1. Show large Terraform configuration file
    - *Action: open the `main.tf` file.*
        - From your local VScode and the cloned repository, open the `main.tf` file.
    - Talk Track: "Let me show you something that might look familiar. This is a Terraform configuration someone wrote when they were just getting started. Everything's in one giant file. EC2 instances, VPCs, S3 buckets—all mixed together. Now, we all know this isn't best practice. Terraform has style guides, we should be using modules, we should organize by component. But if you're new to Terraform, or working under pressure, this is what happens. And here's the kicker: standard Copilot won't help you fix this properly because it doesn't know about your organization's private modules or your specific standards. So what does a developer do? They stop coding and start googling. They browse the registry. They ping the platform team on Slack. They context-switch out of their flow. This is where productivity dies. This MCP server gives my AI assistant a direct line to Terraform. It can query the public registry, access my organization's private registry, list my workspaces, and even help manage Terraform operations. The AI now has infrastructure context."

1. Install Agent Skills
    - Talk Track: "But we can make this even more powerful. HashiCorp has created Agent Skills. These are like specialized instructions that teach AI assistants about HashiCorp best practices. Let me install the Terraform Style Guide Agent Skill."
    - *Action: install the Terraform Style Guide Agent Skill.*
        - Open your Terminal, navigating to the directory in which you've stored the demo-terraform-terraform-mcp-server-template repo.
        - Run the following command to insert the Terraform Style Guide Agent Skill:

            ```copy
            npx skills add hashicorp/agent-skills
            ```

        - You'll be prompted with an interactive CLI to choose the skills to download. Arrow down to the **terraform-style-guide** skill to select it. At this point you can mention the other skills that are also available but we will only be demoing the one.
        - Next you'll be asked if if you want to install any additional agents. Hit enter to bypass this as no other agents are necessary.
        - Choose the **Project** level installation scope.
        - Choose the **Symlink** installation method.
        - Then select **Yes** to proceed with the installation.
    - *Action: show the Agent Skill that was installed in your working directory.*
        - Navigate back to your local VScode and notice a `.agents` directory that was added to your working directory.
        - Open the `.agents/skills/terraform-style-guide/SKILLS.md` file to explore the skill we've decided to use.
    - *Action: try invoking the skill.*
        - Open the Copilot chat box in VScode.
        - Type `/terraform-style-guide` and see the skill listed.
    - Talk Track: "This skill is now teaching Copilot how HashiCorp recommends structuring Terraform code. Combined with the MCP server's access to my private registry, the AI now knows both the 'what' and the 'how.'"

1. Use the Terraform MCP Server + Agent Skills to restructure your code

    > **DISCLAIMER:** Because we are using an AI coding assistant, we cannot guarantee results will always be the same from the below prompts. Please note you might need to provide extra prompts to help guide Copilot down the right path for this demo. Additionally, you will likely have to approve actions Copilot will take and accept the code it generates for you.

    - Talk Track: "Let's have a conversation with Terraform about fixing this code. Watch how natural this is. I want to start refactoring my code base to follow the Terraform style guide, as well as try to minimize my code by using modules that are deemed secure by my organization. The Terraform MCP server has access to my HCP Terraform private module registry and can help me restructure my code to ensure I'm writing compliant code."

    > **NOTE:** When Copilot makes changes, ensure you don't keep duplicate work. For example, if it creates new files with code from your `main.tf`, ensure the `main.tf` file no longer has those resources.

    - *Action: start by separating your code into multiple files.*
        - First separate your long `main.tf` file into separate files grouped by component:

            ```copy
            Can you separate out my main.tf file into smaller files that are grouped by component and name the files accordingly based on the groupings made?
            ```

        - End result should be new files such as `networking.tf`, `compute.tf`, `s3.tf`, etc.

    - Talk Track: "There we go. Copilot just restructured my entire codebase following Terraform best practices. What would have taken me 20 minutes and several Google searches just happened in seconds. Notice in these files, I'm using some basic AWS resources - EC2 instances, S3 buckets, and a VPC. Remember how I said the MCP server connects to my HCP Terraform organization? This means Copilot can see my private module registry. Let me ask if there are modules I should be using."
    - *Action: check to see if I have any private modules available to use.*
        - List out the AWS private modules. **NOTE: you are using the DDR private registry which has all our no-code modules for demos, so let's only list AWS modules.** Use the following prompt to do so:

            ```copy
            Can you see if there are any AWS modules in my private registry in the hashicorp-wwtfo-demo-platform-prod org I could potentially use here?
            ```

    - Talk Track: "Perfect! My organization has already created approved, standardized modules for exactly the resources I need. This is huge! Instead of reinventing the wheel, I can leverage modules that have already been vetted, tested, and approved by my platform team. This is the shift from individual contributors writing raw resources to teams leveraging organizational standards. And it all happened through a simple question in natural language. Let's try using them in my configuration."
    - *Action: modularize your code with the private modules.*
        - Prompt Copilot with the following to use those modules from the private registry:

            ```copy
            Within each of my new files, can you use the ec2-instance, s3-bucket, and vpc modules respectively to modularize the code I currently have?
            ```

        - End result should be smaller config files using modules vs. resources.
    - Talk Track: "Look at this. Clean, readable, modular. More importantly, compliant with my organization's standards. Anyone on my team can look at this code and immediately understand it because we're using shared modules with consistent interfaces. But let's go one step further. What if I want to package this entire pattern as a reusable module that my team can leverage? Let's ask Copilot to do that."
    - *Action: create a module from the code generated.*
        - Modularize the code you have into a local module with the following prompt:

            ```copy
            Now I want to package all those files into a local module. Can you name this local module my-module? Ensure the test.txt file and other necessary Terraform config files are also moved into this new module directory.
            ```

        - End result should be all your files you originally had in a new local module directory and the `main.tf` file in your home directory has a module block calling `my-module`. **Make sure the `test.txt` file gets moved into the local module directory and is referenced correctly in the `aws_s3_object` resource!** You should not have any duplicate files from the module left over here. Manual intervention or extra prompting might be necessary.
    - Talk Track: "Excellent. Now I have a properly structured local module. Let's make sure it's customizable with proper input variables."
    - *Action: ensure the my-module is customizable.*
        - Make sure you can provide custom inputs to `my-module`:

            ```copy
            I want to be able to customize `my-module`. Can you make sure there are valid input variables that allow me to do so?
            ```

        - End result should be variables added to `my-module` as well as the module block calling `my-module` within your root module.
    - Talk Track: "Perfect. Now my root module calls my custom module, which internally uses my organization's private modules. This is proper abstraction! I've created a reusable pattern that can be shared with my team. Now for the final piece of actually deploying this infrastructure. I could run terraform init, plan, and apply manually. But why should I, when I can just ask?"
    - *Action: kick off a run to apply the configuration.*
        - Ask Copilot to help create the workspace and apply the configuration:

            ```copy
            Can you help me apply this configuration through a CLI driven run? Make sure to reference my terraform.tf file where I have my org, project, and workspace name defined.
            ```

        - You can also ask for the status of the run from Copilot to get a general idea of what happened in the run:

            ```copy
            Can you tell me what the status of the latest run is?
            ```

    - *Action: ensure the run succeeds.*
        - Ensure your `terraform apply` succeeds, if it doesn't for whatever reason, leverage Copilot to help you debug to fix the issue!

1. (**Optional**) Deploy a no-code module via the MCP server
    - Talk Track: "The MCP server also has the capability of deploying a no-code module from your private registry directly for you. If there are input variables required for a no-code module, it will prompt you to input that value. Let's first list out those modules again."
    - *Action: list all available modules.*
        - View all the modules available in the DDR org:

            ```copy
            Can you list out all the modules in the private registry of the hashicorp-wwtfo-demo-platform-prod org again?
            ```

    - Talk Track: "Now let's go ahead and try to deploy one of these!"
    - *Action: deploy a DDR no-code module into your project.*
        - Use the following prompt to deploy the **workspaces-projects-rbac** demo:

            ```copy
            Can you provision the workspaces-projects-rbac no-code module for me in my <YOUR DDR PROJECT NAME> project?
            ```

        - Apply the run once it has been triggered.

</details>

<details>
<summary>Use Case 2: Generate a Terraform module from scratch (Click to expand)</summary>

1. Introduction to module generation
    - Talk Track: "Picture a developer on your platform team who gets a ticket: deploy a new S3 bucket with encryption, lifecycle policies, and tagging that meets your org's standards. Today, that journey looks something like this—write a requirements doc, find someone who knows your Terraform conventions, run the code through a style review, write tests, then write documentation that will be out of date the moment the next PR merges. Each step is manual. Each step is disconnected. And the developer who just wants to ship something is stuck waiting on four different people. The cost isn't just time—it's the inconsistency that creeps in when every team does this slightly differently, and the compliance gaps that show up months later."

    - Talk Track: "What we're going to show you is a different model. The MCP Server gives the AI assistant live context about your infrastructure—what providers are available, what modules already exist, what your organization's standards actually are. And when you pair that with a set of Agent Skills, you get guided AI workflows that encode the full module development lifecycle end to end: capturing intent, building acceptance criteria, generating code, and producing documentation—all in a single conversation, all consistent with your standards. Let's install those skills now."
    - *Action: install the Terraform module generation Agent Skills.*
        - Open your Terminal and navigate to the directory of your cloned repository.
        - Run the following command to install the module generation skills:

            ```copy
            npx skills add hashicorp-sa/terraform-agent-skills -y -a github-copilot
            ```

        - This installs five skills: `terraform-module-story-builder`, `terraform-module-acceptance-criteria-builder`, `terraform-module-code-generator`, `terraform-module-requirements-builder` and `terraform-module-documentation-writer`.

1. Set up the workflow governance file
    - Talk Track: "These skills map to a two-phase workflow: **Specify**, then **Generate**. The Specify phase transforms a plain-English description into a testable, structured specification—complete with user stories, EARS-format requirements, variable contracts, and output definitions. Only once that specification passes a quality gate do we move to the Generate phase, which produces the actual Terraform code and documentation. We govern this workflow through an `AGENTS.md` file at the root of our working directory. This file tells Copilot exactly how to sequence the skills and what the quality gates are—no improvising, no skipping steps."
    - *Action: add the `AGENTS.md` workflow governance file to the project root.*
        - In VScode, create a new file called `AGENTS.md` at the root of your working directory with the following content:

            ```markdown
            # Agent Workflows for Terraform Module Specification and Generation

            This file defines portable, harness-agnostic workflows for this repository.
            It intentionally keeps orchestration here, not inside individual skills.

            ## Workflow: Specify

            Goal: produce a testable module specification document.

            Steps:

            1. Run `terraform-module-story-builder` to create a normalized user story.
            2. Run `terraform-module-acceptance-criteria-builder` to derive EARS requirements,
            variable specification, and output specification.
            3. Save a specification artifact that includes at least:
            - User story
            - Scope
            - EARS requirements
            - Variable Specification
            - Output Specification

            Expected artifact:

            - `requirements/module_specification.md` (or equivalent path requested by user)

            Quality gate:

            - Do not proceed to Generate if the specification is ambiguous or missing
            testable requirement statements.

            ## Workflow: Generate

            Goal: generate a Terraform module from a complete specification.

            Preconditions:

            - A complete, testable specification exists.

            Steps:

            1. Run `terraform-module-code-generator` to generate:
            - `main.tf`
            - `variables.tf`
            - `outputs.tf`
            - `versions.tf`
            2. Apply Terraform style conventions using `terraform-style-guide`
            (from HashiCorp Agent Skills).
            3. Generate or update tests using `terraform-test`
            (from HashiCorp Agent Skills).
            4. Generate or update module README using
            `terraform-module-documentation-writer`.

            Output:

            - A module directory with implementation, tests, and documentation.

            ## Workflow: Specify + Generate

            Goal: go from initial intent to validated module implementation.

            Order:

            1. Execute Workflow: Specify.
            2. Validate specification completeness and testability.
            3. Execute Workflow: Generate.

            Rule:

            - Never skip specification quality checks before generation.
            ```

1. Generate the module

    > **DISCLAIMER:** Because we are using an AI coding assistant, we cannot guarantee results will always be the same from the below prompts. Please note you might need to provide extra prompts to help guide Copilot down the right path for this demo. Additionally, you will likely have to approve actions Copilot will take and accept the code it generates for you.

    - Talk Track: "With our governance file in place, Copilot now knows the rules of the road. Let's give it a real-world challenge: building a reusable AWS networking module for sandbox environments. The description I'm going to give it is deliberately written in plain business language—no Terraform syntax, no resource names. This is exactly the kind of input a developer or solutions architect might hand off from a customer conversation or architecture review."

    - *Action: kick off the Specify + Generate workflow in Copilot chat.*
        - Open the Copilot chat box in VScode and enter the following prompt:

            ```copy
            Create a Terraform module, for publication in a private registry, based on the following description.

            In a single sandbox AWS account, use one VPC per environment (for example dev, test, prod), each with its own non-overlapping CIDR block and no Transit Gateway or complex hub-and-spoke routing. This keeps network isolation clear at the VPC boundary while remaining simple to manage and reason about when you are experimenting or running lower-risk workloads.

            Within each environment VPC, create public and private subnets across two or three Availability Zones, placing internet-facing components such as Application Load Balancers and NAT gateways in the public subnets, and application instances, containers, and databases in the private subnets. Route tables are configured so private subnets have outbound internet access only through NAT gateways, and all access between tiers is controlled by security groups and NACLs, giving you a straightforward yet production-aligned pattern for sandbox deployments.

            Allow to provide parameters (with reasonable defaults) for:

            - AWS region
            - Environment name / stage
            - VPC CIDR block per environment, plus lists of public and private subnet CIDRs.
            - Availability Zones to use (for example ["ca-central-1a","ca-central-1b","ca-central-1d"])
            - Common tagging and naming inputs: project or application name, owner/team, cost center, compliance domain

            There should be at least one example showing how to use the module in the module's documentation.
            ```

        > **NOTE:** Copilot will run through both the Specify and Generate workflows sequentially, guided by `AGENTS.md`. You may be prompted to approve intermediate actions—accept them. The specification document will be saved to `requirements/module_specification.md` before any code is generated.

    - Talk Track: "Notice what happened here. Before a single line of Terraform was written, Copilot produced a structured specification: a user story anchored to a real deployment scenario, EARS-format requirements that are unambiguous and testable, and a precise variable and output contract. This isn't just documentation—it's a quality gate. Teams that skip this step end up with modules that don't match what was asked for, or that break when requirements change. By encoding the specification first, we get something every platform team wants: a module that is predictable, auditable, and safe to publish to a shared registry."
    - Talk Track: "Now let's look at what the Generate phase produced. Four files—`main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`—generated directly from the specification. The `terraform-style-guide` skill ran automatically to enforce organizational conventions. Tests were scaffolded by the `terraform-test` skill. And the `terraform-module-documentation-writer` skill produced a `README.md` with an actual usage example. What used to take a senior engineer a day or more to write from scratch just happened in minutes, and the output is consistent with every other module in your registry because it followed the same skills, the same style guide, and the same documentation template every time."
    - *Action: review the generated module artifacts in VScode.*
        - Navigate through the generated files: `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`.
        - Open `requirements/module_specification.md` to show the specification that governed the generation.
        - Open the generated module `README.md` to highlight the usage example.
    - Talk Track: "Think about what just happened. A developer started with a plain-English description and ended up with a fully structured, style-compliant, tested, and documented Terraform module—ready to publish to a shared registry. No Terraform expert needed to scaffold it. No separate docs ticket. No style guide review cycle. The specification isn't an afterthought you write at the end; it's the contract that governs everything that gets generated. That means when requirements change, you update the spec, regenerate, and every artifact stays in sync. That's how platform teams stop being a bottleneck and start being a force multiplier."

</details>

#### Summary

1. Summary and Conclusion
    - Talk Track: "Let's take a step back and think about what we've covered today. The Terraform MCP Server connects your AI assistant directly to your infrastructure—your private registry, your organization's standards, your live workspace data. Agent Skills add a layer of guided, best-practice workflows on top of that context. Together, they address two of the biggest sources of friction in platform engineering: the cost of maintaining existing infrastructure code that doesn't follow standards, and the cost of building new infrastructure that has to be right from day one. Whether you're cleaning up technical debt or accelerating net-new module development, you're doing it through natural language—without leaving your IDE, without context-switching, and without waiting for a specialist. That's what it means to make your AI assistant actually infrastructure-aware. This is how you scale platform engineering without scaling headcount, and how you maximize the investment your organization has already made in HCP Terraform and your private module registry."

## Cleanup

To help manage cloud costs effectively, we prefer you queue a destroy run to clean up the resources from each demo. For this demo, you must first run a `terraform destroy` on your local working directory:

- Navigate to your local directory of `demo-terraform-terraform-mcp-server-template`.
- Run a `terraform destroy` and approve the destroy

After cleaning up the resources from the demo, queue a destroy on the no-code provisioned workspace:

- In your no-code provisioned workspace, navigate to the **Settings** tab on the left-side navigation panel
- Click on **Destruction and Deletion**
- Scroll down and click the red box labeled **Queue destroy plan**
- Enter the name of the workspace and confirm the destroy

You can keep the workspace for each demo module in your `hc-<username>` project, however, we suggest you destroy the resources associated with each module when you're done using it and reprovision when needed.