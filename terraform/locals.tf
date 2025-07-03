locals {
  control_cloud_init = templatefile("${path.module}/files/cloud-init/control_cloud_init.yaml", {
    public_key_control_vm = var.public_key_control_vm
    public_key_user1      = var.public_key_user1
    public_key_user2      = var.public_key_user2
  })

  k8s_master_cloud_init = templatefile("${path.module}/files/cloud-init/k8s_master_cloud_init.yaml", {
    public_key_control_vm = var.public_key_control_vm
    public_key_user1      = var.public_key_user1
    public_key_user2      = var.public_key_user2
  })

  k8s_worker_cloud_init = templatefile("${path.module}/files/cloud-init/k8s_worker_cloud_init.yaml", {
    public_key_control_vm = var.public_key_control_vm
    public_key_user1      = var.public_key_user1
    public_key_user2      = var.public_key_user2
  })
}