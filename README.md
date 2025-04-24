# homelab-k8s

Homelab-k8s is a project that utilizes Proxmox, Terraform and Ansible to automate the deployment of a k8s-cluster.

## Installation

Use git clone to download the project.

```bash
git clone https://github.com/mathiasunneland/homelab-k8s.git
cd homelab-k8s
```

## Dependencies

To use this project you need these dependencies installed locally:

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Go](https://go.dev/doc/install)

And a running Proxmox host on the same network:

- [Proxmox](https://www.proxmox.com/en/products/proxmox-virtual-environment/get-started)

## Usage

The code needs these changes for the project to work:

- The terraform variables has no values by default, so you need to give them values at example.tfvars and renamed to terraform.tfvars
- The project uses "Chess-live" as an example of how to use the project in practice, this will need to be replaced or completely removed

The Proxmox host needs these changes for the project to work:

- The control-vm public key needs to be added to authorized_keys in ~/.ssh
- The local-storage on Proxmox needs to support snippets, so run this and make sure it does:

```bash
nano /etc/pve/storage.cfg # Run this on the Proxmox host shell

dir: local
        path /var/lib/vz
        content iso,vztmpl,backup,snippets # Add "snippets" here like this

lvmthin: local-lvm
        thinpool data
        vgname pve
        content rootdir,images
```

When everything is setup for deployment:
```terraform
# Initialize terraform
terraform init

# Show the execution plan
terraform plan

# Apply the changes
terraform apply
```