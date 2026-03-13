SSTerraform is an Infrastructure as Code (IaC) tool used to provision and manage infrastructure such as servers, networks, and cloud resources using configuration files.

Instead of creating resources manually through the AWS console, Terraform allows us to define infrastructure in code and apply it automatically.

Terraform follows a declarative approach, meaning we define the desired end state of the infrastructure, and Terraform determines how to achieve it.

Unlike some other IaC tools, Terraform is cloud-agnostic and supports multiple providers such as AWS, Azure, and Google Cloud. It also maintains a state file to track managed resources and uses providers to interact with cloud platforms





Terraform will compare the state file with the actual infrastructure in AWS.
Since the instance was deleted manually, Terraform will detect a drift and propose recreating the resource to match the configuration code




Terraform is a declarative Infrastructure as Code tool, meaning the user defines the desired final state of the infrastructure instead of describing the steps to achieve it. Terraform automatically determines the correct execution order and required changes.

Terraform uses a state file to store information about the resources it has created. The state file allows Terraform to compare the current infrastructure with the desired configuration and detect changes or drift.






Terraform provider is a plugin that allows Terraform to interact with an external platform such as AWS, Azure, or Google Cloud.
It defines how Terraform communicates with the provider’s API and includes all the available resource types for that platform.
The provider configuration also includes connection details such as region and credentials.
Without a provider, Terraform cannot create, update, or manage infrastructure resources.






Terraform handles dependency resolution by building a dependency graph based on resource references in the configuration.
When one resource references another (for example, using its ID), Terraform automatically understands the dependency and creates resources in the correct order.
If needed, explicit dependencies can be defined using the depends_on argument.
Terraform uses this graph to determine execution order and creates independent resources in parallel whenever possible.





A Terraform configuration file contains the infrastructure definition written using resources, which specify the cloud components to be created.
It also includes a provider block that defines the cloud platform and region.
Variables are used to make the configuration flexible and reusable, allowing customization without modifying the core code.
Additionally, outputs, modules, and backend configuration may be included depending on the project requirements





terraform plan compares the Terraform configuration, the state file, and the actual infrastructure in AWS. It shows what resources will be created, modified, or destroyed without making any changes.

terraform apply executes the changes proposed in the plan and creates, updates, or deletes infrastructure resources accordingly






In a local backend, the Terraform state file is stored on each developer’s local machine. When multiple engineers work on the same project, each one has a different state file, which can cause inconsistencies, conflicts, or state corruption. A remote backend is preferred because it stores a shared state and supports state locking.








To prevent state corruption when multiple engineers work on the same infrastructure, a remote backend should be used. A remote backend stores a shared state file in a central location (such as S3) and supports state locking. This prevents multiple users from running apply simultaneously and avoids state corruption or conflicts.








terraform refresh
terraform refresh updates the state file to match the real infrastructure in the cloud (e.g., AWS). It does not create, modify, or delete resources. It only synchronizes the state file with the actual infrastructure.

terraform plan
terraform plan compares the Terraform configuration, the current state file, and the real infrastructure. It shows what resources will be created, modified, or destroyed, but does not make any changes.

terraform apply
terraform apply executes the changes proposed in the plan. It creates, updates, or deletes infrastructure





Why is remote backend safer in a team environment?

A remote backend is safer because all team members use a shared state file.
This prevents inconsistencies between different local state files.

It also supports state locking, which ensures that only one person can run terraform apply at a time.
This prevents state corruption and accidental infrastructure conflicts.






State corruption can be prevented by using a remote backend such as AWS S3 to store the shared state file.

In addition, enabling state locking (for example using DynamoDB in AWS) ensures that only one engineer can run terraform apply at a time.



Using Terraform modules improves reusability, maintainability, and consistency. Instead of duplicating code multiple times, infrastructure logic is written once and reused across environments. This reduces errors, simplifies updates, and ensures standardized infrastructure across teams





Variables are passed to a Terraform module through the module block in the root configuration file.

Inside the module, variables are defined using the variable block.
In the root module, values are assigned to those variables when calling the module.

If no value is provided and no default is defined, Terraform will return an error.




count is used to create multiple identical resources based on a number. Resources are indexed numerically.

for_each is used to create multiple resources based on a map or set of values. Each resource is identified by a unique key.

for_each is more stable when managing dynamic resources because it tracks resources by key rather than by index.




A Terraform module can be sourced from a Git repository by specifying the Git URL in the source argument inside the module block.

For example:

source = "git::https://github.com/example-org/vpc-module.git"

If the module is located in a subdirectory, a double slash (//) is used to specify the path. A specific version can be referenced using the ?ref= parameter.





To create an EC2 instance in Terraform, you define an aws_instance resource in the configuration file.

You must specify at least the AMI ID and the instance type.

Additionally, the AWS provider must be configured with the appropriate region and credentials.



An AMI (Amazon Machine Image) is a template used to launch EC2 instances.
It contains the operating system and necessary software configuration.





To define a VPC in Terraform, you must create an aws_vpc resource and specify at least the cidr_block.

The CIDR block defines the IP address range of the VPC.

Additional components such as subnets, route tables, and internet gateways are optional and created separately.





The CIDR block defines the IP address range of the VPC.
It determines how many IP addresses are available within the network.




Terraform manages IAM policies by defining IAM resources such as aws_iam_policy, aws_iam_role, and policy attachments in the configuration file.

When terraform apply is executed, Terraform creates or updates the IAM policies in AWS and tracks them in the state file.



When a policy is modified in the Terraform configuration, Terraform detects the change during plan, and apply updates the IAM policy in AWS to match the configuration.





To provision and attach an Elastic Load Balancer in Terraform, you define an aws_lb resource, create a target group, configure a listener, and attach EC2 instances to the target group.

Terraform then provisions the load balancer and connects it to the specified instances.



Companies often use HTTPS at the Load Balancer level to encrypt traffic from the internet.

Inside the VPC, communication is often HTTP because it is internal, secure, and reduces computational overhead.



The terraform validate command checks whether the Terraform configuration files are syntactically valid and internally consistent.

It does not access AWS or verify the actual infrastructure.



Terraform errors can be debugged by carefully reviewing the error message, which usually indicates the file and line number of the issue.

Running terraform validate helps detect syntax errors, and terraform plan can reveal configuration mismatches.

For advanced troubleshooting, Terraform debug logs can be enabled using environment variables.




The ignore_changes lifecycle policy is used to prevent Terraform from detecting and applying changes to specific resource attributes.

It is useful when certain attributes are modified outside of Terraform or updated automatically by the cloud provider.




Existing AWS infrastructure can be imported into Terraform using the terraform import command.

This command adds the existing resource to Terraform’s state file without modifying the actual infrastructure.

After importing, the configuration must match the real resource to avoid unintended changes.



If the configuration does not match the existing AWS resource after import, Terraform will detect differences during plan and may attempt to update or replace the resource during apply.