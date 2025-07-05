# homelab-k8s

Homelab-k8s is a project that utilizes Proxmox, Terraform and Ansible to automate a customized deployment of a k8s-cluster.

## Installation

```bash
# Clone the repository
git clone https://github.com/mathiasunneland/homelab-k8s.git
cd homelab-k8s
```

## Dependencies

To use this project you need these dependencies installed locally:

- [Python 3](https://example.com)
- [Ansible](https://example.com)
- [Terraform](https://developer.hashicorp.com/terraform/install)

And a running Proxmox host on the same network:

- [Proxmox](https://www.proxmox.com/en/products/proxmox-virtual-environment/get-started)

## Usage

The code needs these changes for the project to work:

- The terraform variables has no values by default, so you need to give them values at /terraform/terraformExample.tfvars and rename to terraform.tfvars
- The ansible variables has no values by default, so you need to give them values at /ansible/secretsExample.yaml and rename to secrets.yaml

The Proxmox host needs these changes for the project to work:

- Your public key needs to be added to ~/.ssh/authorized_keys
- The local-storage on Proxmox needs to support snippets, heres how to do it:

```bash
# Run this on the Proxmox host shell
nano /etc/pve/storage.cfg 
```

```bash
 # Add "snippets" on content line of local storage
dir: local
        path /var/lib/vz
        content iso,vztmpl,backup,snippets
```

When everything is setup for deployment:
```bash
# Run the deployment python script
python3 deploy.py
```