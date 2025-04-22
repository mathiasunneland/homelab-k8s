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

variable "private_key_control_vm" {
  description = "The control-vm private key"
  type        = string
  sensitive   = true
}

variable "public_key_control_vm" {
  description = "The control-vm public key"
  type        = string
  sensitive   = true
}

variable "private_key_github" {
  description = "The github private key"
  type        = string
  sensitive   = true
}

variable "public_key_github" {
  description = "The github public key"
  type        = string
  sensitive   = true
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

variable "grafana_username" {
  description = "Admin username for grafana"
  type        = string
  sensitive   = true
}

variable "grafana_password" {
  description = "Admin password for grafana"
  type        = string
  sensitive   = true
}

variable "grafana_lb_ip" {
  description = "lb ip for grafana"
  type        = string
  sensitive   = true
}

variable "grafana_port" {
  description = "port for grafana"
  type        = string
  sensitive   = true
}

variable "loki_port" {
  description = "port for loki"
  type        = string
  sensitive   = true
}

variable "nginx_lb_ip" {
  description = "lb ip for nginx"
  type        = string
  sensitive   = true
}

variable "postgres_database" {
  description = "Database for postgres"
  type        = string
  sensitive   = true
}

variable "postgres_username" {
  description = "Username for postgres"
  type        = string
  sensitive   = true
}

variable "postgres_password" {
  description = "Password for postgres"
  type        = string
  sensitive   = true
}

variable "redis_password" {
  description = "Password for redis"
  type        = string
  sensitive   = true
}

variable "metallb_ipaddresspool" {
  description = "ipaddresspool for metallb"
  type        = string
  sensitive   = true
}

variable "chess_live_domain" {
  description = "Domain for chess-live"
  type        = string
  sensitive   = true
}

variable "vite_tournament_details_url" {
  description = "secret for chess-live"
  type        = string
  sensitive   = true
}

variable "vite_tournament_websocket_url" {
  description = "secret for chess-live"
  type        = string
  sensitive   = true
}

variable "chess_live_db" {
  description = "secret for chess-live"
  type        = string
  sensitive   = true
}

variable "redis_url" {
  description = "secret for chess-live"
  type        = string
  sensitive   = true
}

variable "openai_api_key" {
  description = "secret for chess-live"
  type        = string
  sensitive   = true
}

variable "github_username" {
  description = "secret for ghcr_login_secret"
  type        = string
  sensitive   = true
}

variable "github_email" {
  description = "secret for ghcr_login_secret"
  type        = string
  sensitive   = true
}

variable "imagepull_secret_dockerconfigjson" {
  description = "secret for imagepull_secret"
  type        = string
  sensitive   = true
}

variable "gateway_ip" {
  description = "gateway ip"
  type        = string
  sensitive   = true
}

variable "tailscale_vm_ip" {
  description = "tailscale-vm ip"
  type        = string
  sensitive   = true
}

variable "control_vm_ip" {
  description = "control-vm ip"
  type        = string
  sensitive   = true
}

variable "k8s_master_ip" {
  description = "k8s-master ip"
  type        = string
  sensitive   = true
}

variable "k8s_worker_1_ip" {
  description = "k8s-worker-1 ip"
  type        = string
  sensitive   = true
}

variable "k8s_worker_2_ip" {
  description = "k8s-worker-2 ip"
  type        = string
  sensitive   = true
}

variable "k8s_worker_3_ip" {
  description = "k8s-worker-3 ip"
  type        = string
  sensitive   = true
}

variable "chess_live_api_port" {
  description = "port for chess-live-api"
  type        = number
  sensitive   = true
}

variable "chess_live_front_port" {
  description = "port for chess-live-front"
  type        = number
  sensitive   = true
}