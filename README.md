# homelab-k8s

Homelab-k8s is a project that utilizes Proxmox, Terraform and Ansible to automate a customized deployment of a k8s-cluster.

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
- [jq](https://example.com)

And a running Proxmox host on the same network:

- [Proxmox](https://www.proxmox.com/en/products/proxmox-virtual-environment/get-started)

## Usage

The code needs these changes for the project to work:

- The terraform variables has no values by default, so you need to give them values at /terraform/terraformExample.tfvars and rename to terraform.tfvars
- The ansible variables has no values by default, so you need to give them values at /ansible/secretsExample.yaml and rename to secrets.yaml

The Proxmox host needs these changes for the project to work:

- Your public key needs to be added to authorized_keys in ~/.ssh
- The local-storage on Proxmox needs to support snippets, heres how to do it:

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
```bash
# Run the deployment bash script
bash deploy.sh
```