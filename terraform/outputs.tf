output "k8s_master_ip" {
  value = var.k8s_master_ip
}

output "k8s_worker_ips" {
  value = [
    for i in range(length(proxmox_virtual_environment_vm.k8s_worker)) :
    "${var.k8s_worker_ip_start}.${i + 234}"
  ]
}