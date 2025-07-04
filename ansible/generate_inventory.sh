#!/bin/bash
set -e

echo "[*] Generating Ansible inventory from Terraform output..."

# Capture output from Terraform
TAILSCALE_IP=$(terraform -chdir=../terraform output -json tailscale_vm_ip | jq -r '.value')
CONTROL_IP=$(terraform -chdir=../terraform output -json control_vm_ip | jq -r '.value')
MASTER_IP=$(terraform -chdir=../terraform output -json k8s_master_ip | jq -r '.value')
WORKER_IPS=$(terraform -chdir=../terraform output -json k8s_worker_ips | jq -r '.value[]')

# Format worker IP lines
WORKER_LINES=""
for ip in $WORKER_IPS; do
  WORKER_LINES+="$ip ansible_user=hus"$'\n'
done

# Write the inventory.ini file
cat > inventory.ini <<EOF
[homelab_all]
$TAILSCALE_IP ansible_user=hus
$CONTROL_IP ansible_user=hus
$MASTER_IP ansible_user=hus
$WORKER_LINES

[k8s_all]
$MASTER_IP ansible_user=hus
$WORKER_LINES

[k8s_master]
$MASTER_IP ansible_user=hus

[k8s_workers]
$WORKER_LINES
EOF

echo "[✓] inventory.ini generated successfully."