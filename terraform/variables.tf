variable "pm_ip" {
  description = "The pm ip"
  type        = string
  sensitive   = true
}

variable "pm_endpoint" {
  description = "The pm endpoint"
  type        = string
  sensitive   = true
}

variable "pm_api_token" {
  description = "The pm api token"
  type        = string
  sensitive   = true
}

variable "ssh_private_key_path" {
  description = "ssh private key path"
  type    = string
  sensitive = true
}

variable "public_key_user1" {
  description = "The user1 public key"
  type        = string
  sensitive   = true
}

variable "public_key_user2" {
  description = "The user2 public key"
  type        = string
  sensitive   = true
}

variable "gateway_ip" {
  description = "gateway ip"
  type        = string
  sensitive   = true
}

variable "k8s_master_ip" {
  description = "k8s-master ip"
  type        = string
  sensitive   = false
}

variable "k8s_worker_ip_start" {
  description = "k8s-master ip start"
  type        = string
  sensitive   = false
}