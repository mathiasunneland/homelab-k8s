#!/bin/bash
set -e

echo "Starting deployment"

# Run Terraform
cd terraform
terraform init
terraform apply --auto-approve
cd ..

# Generate Ansible inventory
cd ansible
bash generate_inventory.sh

# Run Ansible playbooks
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini setup_files.yaml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini setup_kubernetes.yaml

echo "Deployment finished"