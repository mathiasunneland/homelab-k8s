# Terraform-kubernetes

Terraform-kubernetes is a project that utilizes Proxmox, Terraform and Ansible to automate the deployment of a k8s-cluster.

## Installation

Use git clone to download the project.

```bash
git clone https://github.com/mathiasunneland/terraform-kubernetes.git
cd terraform-kubernetes
```

## Dependencies

To use this project you need these dependencies installed locally:

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Go](https://go.dev/doc/install)

And a running Proxmox host on the same network:

- [Proxmox](https://www.proxmox.com/en/products/proxmox-virtual-environment/get-started)

## Usage

```terraform
# Initialize terraform
terraform init

# Show the execution plan
terraform plan

# Apply the changes
terraform apply
```