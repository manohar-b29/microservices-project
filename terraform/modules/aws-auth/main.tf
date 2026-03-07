resource "kubernetes_config_map" "aws_auth" {

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {

    mapRoles = <<EOF
- rolearn: ${var.node_role_arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
  - system:bootstrappers
  - system:nodes
EOF

    mapUsers = <<EOF
- userarn: ${var.jenkins_user_arn}
  username: jenkins
  groups:
  - system:masters
EOF

  }
}