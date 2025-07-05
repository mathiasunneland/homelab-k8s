locals {
  k8s_master_cloud_init = templatefile("${path.module}/cloud-init/k8s_master_cloud_init.yaml", {
    public_key_user1 = var.public_key_user1
    public_key_user2 = var.public_key_user2
  })

  k8s_worker_cloud_init = [
    for i in range(var.k8s_worker_count) : templatefile("${path.module}/cloud-init/k8s_worker_cloud_init.yaml", {
      hostname         = "k8s-worker-${i + 1}"
      public_key_user1 = var.public_key_user1
      public_key_user2 = var.public_key_user2
    })
  ]
}