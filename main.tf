resource "proxmox_virtual_environment_file" "control_cloud_init" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data      = local.control_cloud_init
    file_name = "control_cloud_init.yaml"
  }
}

resource "proxmox_virtual_environment_file" "k8s_master_cloud_init" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data      = local.k8s_master_cloud_init
    file_name = "k8s_master_cloud_init.yaml"
  }
}

resource "proxmox_virtual_environment_file" "k8s_worker_1_cloud_init" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data      = local.k8s_worker_1_cloud_init
    file_name = "k8s_worker_1_cloud_init.yaml"
  }
}

resource "proxmox_virtual_environment_file" "k8s_worker_2_cloud_init" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data      = local.k8s_worker_2_cloud_init
    file_name = "k8s_worker_2_cloud_init.yaml"
  }
}

resource "proxmox_virtual_environment_file" "k8s_worker_3_cloud_init" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data      = local.k8s_worker_3_cloud_init
    file_name = "k8s_worker_3_cloud_init.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "ubuntu_template" {
  name      = "ubuntu-template"
  node_name = "pve"

  template = true
  started  = false

  machine     = "q35"
  bios        = "ovmf"
  description = "Managed by Terraform"

  cpu {
    cores = 1
  }

  memory {
    dedicated = 1024
  }

  efi_disk {
    datastore_id = "local-lvm"
    type         = "4m"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  network_device {
    bridge = "vmbr0"
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pve"

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_vm" "control_vm" {
  name      = "control-vm"
  node_name = "pve"

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 1024
  }

  cpu {
    cores = 1
  }

  initialization {
    dns {
      servers = ["1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address    = "${var.control_vm_ip}/24"
        gateway    = var.gateway_ip
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.control_cloud_init.id
  }
}

resource "proxmox_virtual_environment_vm" "k8s_master" {
  name      = "k8s-master"
  node_name = "pve"

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 2048
  }

  cpu {
    cores = 2
  }

  initialization {
    dns {
      servers = ["1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address    = "${var.k8s_master_ip}/24"
        gateway    = var.gateway_ip
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.k8s_master_cloud_init.id
  }
}

resource "proxmox_virtual_environment_vm" "k8s_worker_1" {
  name      = "k8s-worker-1"
  node_name = "pve"

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 4096
  }

  cpu {
    cores = 2
  }

  initialization {
    dns {
      servers = ["1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address    = "${var.k8s_worker_1_ip}/24"
        gateway    = var.gateway_ip
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.k8s_worker_1_cloud_init.id
  }
}

resource "proxmox_virtual_environment_vm" "k8s_worker_2" {
  name      = "k8s-worker-2"
  node_name = "pve"

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 4096
  }

  cpu {
    cores = 2
  }

  initialization {
    dns {
      servers = ["1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address    = "${var.k8s_worker_2_ip}/24"
        gateway    = var.gateway_ip
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.k8s_worker_2_cloud_init.id
  }
}

resource "proxmox_virtual_environment_vm" "k8s_worker_3" {
  name      = "k8s-worker-3"
  node_name = "pve"

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 4096
  }

  cpu {
    cores = 2
  }

  initialization {
    dns {
      servers = ["1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address    = "${var.k8s_worker_3_ip}/24"
        gateway    = var.gateway_ip
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.k8s_worker_3_cloud_init.id
  }
}

resource "null_resource" "copy_files_to_control_vm" {
  depends_on = [
    proxmox_virtual_environment_vm.control_vm
  ]

  provisioner "remote-exec" {
    inline = [
      "echo '${var.private_key_control_vm}' > /home/hus/.ssh/id_ed25519",
      "echo '${var.public_key_control_vm}' > /home/hus/.ssh/id_ed25519.pub",
      "chmod 700 /home/hus/.ssh",
      "chmod 600 /home/hus/.ssh/id_ed25519",
      "chmod 644 /home/hus/.ssh/id_ed25519.pub",

      "mkdir /home/hus/setup",

      # ansible files
      "echo '${local.homelab_inventory}' > /home/hus/setup/homelab_inventory.ini",
      "echo '${file("${path.module}/ansible/update_kernel_playbook.yaml")}' > /home/hus/setup/update_kernel_playbook.yaml",
      "echo '${file("${path.module}/ansible/k8s_all_playbook.yaml")}' > /home/hus/setup/k8s_all_playbook.yaml",
      "echo '${file("${path.module}/ansible/k8s_master_p1_playbook.yaml")}' > /home/hus/setup/k8s_master_p1_playbook.yaml",
      "echo '${local.k8s_workers_playbook}' > /home/hus/setup/k8s_workers_playbook.yaml",
      "echo '${local.k8s_master_p2_playbook}' > /home/hus/setup/k8s_master_p2_playbook.yaml"
    ]

    connection {
      type        = "ssh"
      host        = var.control_vm_ip
      user        = "hus"
      private_key = var.private_key_control_vm
    }
  }
}

resource "null_resource" "copy_files_to_k8s_master" {
  depends_on = [
    proxmox_virtual_environment_vm.k8s_master
  ]

  provisioner "remote-exec" {
    inline = [
      "echo '${var.private_key_github}' > /home/hus/.ssh/id_ed25519",
      "echo '${var.public_key_github}' > /home/hus/.ssh/id_ed25519.pub",
      "chmod 700 /home/hus/.ssh",
      "chmod 600 /home/hus/.ssh/id_ed25519",
      "chmod 644 /home/hus/.ssh/id_ed25519.pub",

      "mkdir /home/hus/setup",

      # kubectl files
      "echo '${local.cluster_issuer}' > /home/hus/setup/clusterissuer.yaml",
      "echo '${local.chess_live_ingress}' > /home/hus/setup/chess_live_ingress.yaml",
      "echo '${local.metallb_config}' > /home/hus/setup/metallb_config.yaml",
      "echo '${local.chess_live_secrets}' > /home/hus/setup/chess_live_secrets.yaml",
      "echo '${local.imagepull_secrets}' > /home/hus/setup/imagepull_secrets.yaml",

      # helm files
      "echo '${local.grafana_values}' > /home/hus/setup/grafana_values.yaml",
      "echo '${file("${path.module}/helm/loki_values.yaml")}' > /home/hus/setup/loki_values.yaml",
      "echo '${file("${path.module}/helm/prometheus_values.yaml")}' > /home/hus/setup/prometheus_values.yaml",
      "echo '${local.nginx_values}' > /home/hus/setup/nginx_values.yaml",
      "echo '${local.postgres_values}' > /home/hus/setup/postgres_values.yaml",
      "echo '${local.redis_values}' > /home/hus/setup/redis_values.yaml",
      "echo '${file("${path.module}/ansible/update_helm_charts_playbook.yaml")}' > /home/hus/setup/update_helm_charts_playbook.yaml",

      # kubeadm files
      "echo '${local.kubeadm_init_config}' > /home/hus/setup/kubeadm_init_config.yaml",

      # service files
      "echo '${file("${path.module}/service/helm_upgrade.service")}' > /home/hus/setup/helm_upgrade.service"
    ]

    connection {
      type        = "ssh"
      host        = var.k8s_master_ip
      user        = "hus"
      private_key = var.private_key_control_vm
    }
  }
}

resource "null_resource" "copy_files_to_k8s_worker_1" {
  depends_on = [
    proxmox_virtual_environment_vm.k8s_worker_1
  ]

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/hus/setup",

      # kubeadm files
      "echo '${local.kubeadm_join_config}' > /home/hus/setup/kubeadm_join_config.yaml",
    ]

    connection {
      type        = "ssh"
      host        = var.k8s_worker_1_ip
      user        = "hus"
      private_key = var.private_key_control_vm
    }
  }
}

resource "null_resource" "copy_files_to_k8s_worker_2" {
  depends_on = [
    proxmox_virtual_environment_vm.k8s_worker_2
  ]

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/hus/setup",

      # kubeadm files
      "echo '${local.kubeadm_join_config}' > /home/hus/setup/kubeadm_join_config.yaml",
    ]

    connection {
      type        = "ssh"
      host        = var.k8s_worker_2_ip
      user        = "hus"
      private_key = var.private_key_control_vm
    }
  }
}

resource "null_resource" "copy_files_to_k8s_worker_3" {
  depends_on = [
    proxmox_virtual_environment_vm.k8s_worker_3
  ]

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/hus/setup",

      # kubeadm files
      "echo '${local.kubeadm_join_config}' > /home/hus/setup/kubeadm_join_config.yaml",
    ]

    connection {
      type        = "ssh"
      host        = var.k8s_worker_3_ip
      user        = "hus"
      private_key = var.private_key_control_vm
    }
  }
}

resource "null_resource" "ansible_setup" {
  depends_on = [
    proxmox_virtual_environment_vm.control_vm,
    proxmox_virtual_environment_file.k8s_master_cloud_init,
    proxmox_virtual_environment_file.k8s_worker_1_cloud_init,
    proxmox_virtual_environment_file.k8s_worker_2_cloud_init,
    proxmox_virtual_environment_file.k8s_worker_3_cloud_init,
    null_resource.copy_files_to_control_vm,
    null_resource.copy_files_to_k8s_master,
  ]

  provisioner "remote-exec" {
    inline = [
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /home/hus/setup/homelab_inventory.ini /home/hus/setup/k8s_all_playbook.yaml",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /home/hus/setup/homelab_inventory.ini /home/hus/setup/k8s_master_p1_playbook.yaml",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /home/hus/setup/homelab_inventory.ini /home/hus/setup/k8s_workers_playbook.yaml",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /home/hus/setup/homelab_inventory.ini /home/hus/setup/k8s_master_p2_playbook.yaml",
    ]

    connection {
      type        = "ssh"
      host        = var.control_vm_ip
      user        = "hus"
      private_key = var.private_key_control_vm
    }
  }
}