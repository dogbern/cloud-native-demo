provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "release-prometheus-operator" {
  source  = "OpenQAI/release-prometheus-operator/helm"
  version = "0.0.6"

  helm_chart_version     = "8.15.11"
  helm_chart_namespace   = "monitoring"
  skip_crds              =  false
  grafana_image_tag      = "7.0.3"
  grafana_adminPassword  = "pa$$w0rd"
  alertmanager_service_type = "LoadBalancer"
  grafana_service_type = "LoadBalancer"
  prometheus_service_type = "LoadBalancer"

}

resource "helm_release" "k8s_dashboard" {
  name       = "demo"

  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
}