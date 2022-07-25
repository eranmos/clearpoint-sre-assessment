##################
# EKS Namespace  #
##################
resource "kubernetes_namespace" "application_namespace" {

  metadata {
    annotations = {
      name = "${var.application_namespace}"
    }
    name = "${var.application_namespace}"
  }
}