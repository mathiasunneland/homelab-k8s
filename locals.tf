locals {
  control_cloud_init = templatefile("${path.module}/cloud-init/control_cloud_init.yaml", {
    public_key_control_vm = var.public_key_control_vm
    public_key_user1      = var.public_key_user1
    public_key_user2      = var.public_key_user2
  })

  k8s_master_cloud_init = templatefile("${path.module}/cloud-init/k8s_master_cloud_init.yaml", {
    public_key_control_vm = var.public_key_control_vm
    public_key_user1      = var.public_key_user1
    public_key_user2      = var.public_key_user2
  })

  k8s_worker_1_cloud_init = templatefile("${path.module}/cloud-init/k8s_worker_1_cloud_init.yaml", {
    public_key_control_vm = var.public_key_control_vm
    public_key_user1      = var.public_key_user1
    public_key_user2      = var.public_key_user2
  })

  k8s_worker_2_cloud_init = templatefile("${path.module}/cloud-init/k8s_worker_2_cloud_init.yaml", {
    public_key_control_vm = var.public_key_control_vm
    public_key_user1      = var.public_key_user1
    public_key_user2      = var.public_key_user2
  })

  k8s_worker_3_cloud_init = templatefile("${path.module}/cloud-init/k8s_worker_3_cloud_init.yaml", {
    public_key_control_vm = var.public_key_control_vm
    public_key_user1      = var.public_key_user1
    public_key_user2      = var.public_key_user2
  })

  k8s_inventory = templatefile("${path.module}/ansible/k8s_inventory.ini", {
    k8s_master_ip   = var.k8s_master_ip
    k8s_worker_1_ip = var.k8s_worker_1_ip
    k8s_worker_2_ip = var.k8s_worker_2_ip
    k8s_worker_3_ip = var.k8s_worker_3_ip
  })

  k8s_master_p2_playbook = templatefile("${path.module}/ansible/k8s_master_p2_playbook.yaml", {
    github_username = var.github_username
  })

  k8s_workers_playbook = templatefile("${path.module}/ansible/k8s_workers_playbook.yaml", {
    k8s_master_ip = var.k8s_master_ip
  })

  cluster_issuer = templatefile("${path.module}/kubectl/clusterissuer.yaml", {
    github_email = var.github_email
  })

  metallb_config = templatefile("${path.module}/kubectl/metallb_config.yaml", {
    metallb_ipaddresspool = var.metallb_ipaddresspool
  })

  imagepull_secrets = templatefile("${path.module}/kubectl/imagepull_secrets.yaml", {
    imagepull_secret_dockerconfigjson = var.imagepull_secret_dockerconfigjson
  })

  chess_live_ingress = templatefile("${path.module}/kubectl/chess_live_ingress.yaml", {
    chess_live_domain     = var.chess_live_domain
    chess_live_api_port   = var.chess_live_api_port
    chess_live_front_port = var.chess_live_front_port
  })


  chess_live_secrets = templatefile("${path.module}/kubectl/chess_live_secrets.yaml", {
    vite_tournament_details_url   = var.vite_tournament_details_url
    vite_tournament_websocket_url = var.vite_tournament_websocket_url
    chess_live_db                 = var.chess_live_db
    redis_url                     = var.redis_url
    openai_api_key                = var.openai_api_key
  })

  grafana_values = templatefile("${path.module}/helm/grafana_values.yaml", {
    grafana_username = var.grafana_username
    grafana_password = var.grafana_password
    grafana_lb_ip    = var.grafana_lb_ip
    grafana_port     = var.grafana_port
    loki_port        = var.loki_port
  })

  nginx_values = templatefile("${path.module}/helm/nginx_values.yaml", {
    nginx_lb_ip = var.nginx_lb_ip
  })

  postgres_values = templatefile("${path.module}/helm/postgres_values.yaml", {
    postgres_database = var.postgres_database
    postgres_username = var.postgres_username
    postgres_password = var.postgres_password
  })

  redis_values = templatefile("${path.module}/helm/redis_values.yaml", {
    redis_password = var.redis_password
  })

  kubeadm_init_config = templatefile("${path.module}/kubeadm/kubeadm_init_config.yaml", {
    kubeadm_token = var.kubeadm_token
    k8s_master_ip = var.k8s_master_ip
  })

  kubeadm_join_config = templatefile("${path.module}/kubeadm/kubeadm_join_config.yaml", {
    kubeadm_token = var.kubeadm_token
    k8s_master_ip = var.k8s_master_ip
  })
}