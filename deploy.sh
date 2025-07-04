#!/bin/bash
set -e

echo "Starting full deploy"

# Run Terraform
cd terraform
terraform init
terraform apply --auto-approve
cd ..

# Generate Ansible inventory
cd ansible
bash generate_inventory.sh

# Run Ansible playbook
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini k8s_all_playbook.yaml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini k8s_master_p1_playbook.yaml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini k8s_master_p2_playbook.yaml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini k8s_workers_playbook.yaml

echo "Deployment complete"