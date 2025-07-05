#!/usr/bin/env python3
import subprocess
import json
import sys
import os

def run(cmd, cwd=None, env=None):
    print(f"Running: {' '.join(cmd)}")
    subprocess.run(cmd, cwd=cwd, check=True, env=env)

def terraform_output(name):
    result = subprocess.run(
        ["terraform", "output", "-json", name],
        cwd="terraform",
        capture_output=True,
        text=True,
        check=True,
    )
    return json.loads(result.stdout)

def generate_inventory(master_ip, worker_ips, filename="ansible/inventory.ini"):
    with open(filename, "w") as f:
        f.write("[k8s_all]\n")
        f.write(f"{master_ip} ansible_user=hus\n")
        for ip in worker_ips:
            f.write(f"{ip} ansible_user=hus\n")

        f.write("\n[k8s_master]\n")
        f.write(f"{master_ip} ansible_user=hus\n")

        f.write("\n[k8s_workers]\n")
        for ip in worker_ips:
            f.write(f"{ip} ansible_user=hus\n")

    print(f"Inventory written to {filename}")

def main():
    try:
        print("Starting deployment")

        # Run Terraform init and apply
        run(["terraform", "init"], cwd="terraform")
        run(["terraform", "apply", "--auto-approve"], cwd="terraform")

        # Get IPs from Terraform outputs
        master_ip = terraform_output("k8s_master_ip")
        worker_ips = terraform_output("k8s_worker_ips")

        # Generate inventory file for Ansible
        generate_inventory(master_ip, worker_ips)

        # Prepare environment for Ansible (disable SSH host key checking)
        env = os.environ.copy()
        env["ANSIBLE_HOST_KEY_CHECKING"] = "False"

        # Run Ansible playbooks inside ansible directory
        run(["ansible-playbook", "-i", "inventory.ini", "setup_files.yaml"], cwd="ansible", env=env)
        run(["ansible-playbook", "-i", "inventory.ini", "setup_kubernetes.yaml"], cwd="ansible", env=env)

        print("Deployment finished successfully")

    except subprocess.CalledProcessError as e:
        print(f"Error: Command '{e.cmd}' failed with exit code {e.returncode}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()