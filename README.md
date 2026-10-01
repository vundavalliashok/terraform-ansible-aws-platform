# Terraform and Ansible AWS Platform

This project uses Terraform to provision AWS infrastructure, with Ansible intended for later host configuration. The currently implemented Terraform configuration provisions a VPC and public networking. EC2, security-group, and Ansible deployment components are not implemented yet.

## Current Infrastructure

The root Terraform configuration uses the `vpc` module to create:

- A VPC with DNS support and DNS hostnames enabled.
- An internet gateway attached to the VPC.
- One public subnet for each configured availability zone, with public IPv4 assignment enabled on launch.
- A public route table with a default route (`0.0.0.0/0`) through the internet gateway, associated with each public subnet.

The root module exports the VPC ID and public subnet IDs. There are no EC2 instances, security groups, private subnets, Ansible playbooks, or application deployment steps in the current implementation.

## Repository Structure

```text
.
|-- .github/workflows/       # Placeholder for CI/CD workflows
|-- ansible/
|   |-- inventory/           # Placeholder for Ansible inventory
|   |-- playbooks/           # Placeholder for playbooks
|   `-- roles/
|       |-- common/          # Placeholder role
|       |-- docker/          # Placeholder role
|       `-- nginx/           # Placeholder role
|-- application/             # Placeholder for application files
|-- scripts/                 # Placeholder for helper scripts
|-- terraform/
|   |-- main.tf              # Root module configuration
|   |-- providers.tf         # Terraform and AWS provider requirements
|   |-- variables.tf         # Root input variables and defaults
|   |-- outputs.tf            # VPC ID and public subnet IDs
|   |-- terraform.tfvars.example
|   `-- modules/
|       |-- vpc/              # Implemented VPC and public networking
|       |-- ec2/              # Placeholder module
|       `-- security/         # Placeholder module
`-- README.md
```

## Prerequisites

- Terraform CLI 1.6.0 or later.
- An AWS account and credentials available to the AWS provider, such as through the AWS CLI profile or standard AWS environment variables.
- IAM permissions to manage VPCs, subnets, internet gateways, route tables, and route-table associations.

The AWS provider is constrained to the `6.x` release line. The default region is `ap-south-1`.

## Configuration

Root inputs and defaults are defined in `terraform/variables.tf`. The example values are in `terraform/terraform.tfvars.example`:

| Variable | Default | Purpose |
| --- | --- | --- |
| `aws_region` | `ap-south-1` | AWS region for the provider |
| `project_name` | `terraform-ansible-platform` | Prefix for resource names and tags |
| `environment` | `dev` | Environment tag and name component |
| `vpc_cidr` | `10.20.0.0/16` | VPC address range |
| `availability_zones` | `ap-south-1a`, `ap-south-1b` | Zones receiving public subnets |

Create `terraform/terraform.tfvars` from the example if it does not already exist, then edit the values for your account and region. If you change `aws_region`, also set availability zones that belong to that region. The local `.tfvars` file is ignored by Git; do not commit credentials or other secrets.

## Deploy

Run these commands from the repository root in PowerShell:

```powershell
terraform -chdir=terraform init
terraform -chdir=terraform validate
terraform -chdir=terraform plan
terraform -chdir=terraform apply
```

Review the plan before approving the apply. Terraform prints the outputs after deployment; they can also be queried later:

```powershell
terraform -chdir=terraform output vpc_id
terraform -chdir=terraform output public_subnet_ids
```

To remove the resources managed by this configuration, run `terraform -chdir=terraform destroy` and review the proposed changes before confirming.