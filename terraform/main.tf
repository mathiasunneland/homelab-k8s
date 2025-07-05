resource "proxmox_virtual_environment_file" "k8s_master_cloud_init" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data      = local.k8s_master_cloud_init
    file_name = "k8s-master-cloud-init.yaml"
  }
}

resource "proxmox_virtual_environment_file" "k8s_worker_cloud_init" {
  count        = var.k8s_worker_count
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data      = local.k8s_worker_cloud_init[count.index]
    file_name = "k8s-worker-${count.index + 1}-cloud-init.yaml"
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pve"

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_vm" "ubuntu_template" {
  name      = "ubuntu-template"
  vm_id     = 200
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

resource "proxmox_virtual_environment_vm" "k8s_master" {
  name      = "k8s-master"
  vm_id     = 202
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

resource "proxmox_virtual_environment_vm" "k8s_worker" {
  count     = var.k8s_worker_count
  name      = "k8s-worker-${count.index + 1}"
  vm_id     = count.index + 203
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
        address    = "${var.k8s_worker_ip_start}.${count.index + 233}/24"
        gateway    = var.gateway_ip
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.k8s_worker_cloud_init[count.index].id
  }
}