# homelab-k8s
Homelab-k8s is a project that utilizes Proxmox, Terraform and Ansible to automate a customized deployment of a k8s-cluster.

## Installation
```bash
# Clone the repository
git clone https://github.com/mathiasunneland/homelab-k8s.git
cd homelab-k8s
```

## Prerequisites

**To use this project you need these prerequisites installed locally:**
- [Python 3](https://www.python.org/downloads/)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
- [Terraform](https://developer.hashicorp.com/terraform/install)

**And a running Proxmox host on the same network:**
- [Proxmox](https://www.proxmox.com/en/products/proxmox-virtual-environment/get-started)

## Before Usage

**The code needs these changes for the project to work:**
1. Assign terraform values to `terraformExample.tfvars` and rename to `terraform.tfvars`
2. Assign ansible values to `secretsExample.yaml` and rename to `secrets.yaml`

**The Proxmox host needs these changes for the project to work:**
3. Your public key needs to be added to authorized_keys
```bash
# Run this on the Proxmox host shell
nano ~/.ssh/authorized_keys
```
```bash
# Add your own public key
ssh-ed25519 ABCDEFGHIJKLMNOPQRSTUVWXYZ example@gmail.com
```

4. The local storage on Proxmox needs to support snippets
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

## Usage
**When everything is setup for deployment:**
```bash
# Run the deployment python script
python3 deploy.py
```