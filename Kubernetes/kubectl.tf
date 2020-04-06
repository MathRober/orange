
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kubectl_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }
}

resource "aws_iam_role" "eks_kubectl_role" {
  name               = "poc-kubectl-access-role"
  assume_role_policy = data.aws_iam_policy_document.kubectl_assume_role_policy.json
}
resource "aws_iam_role_policy_attachment" "eks_kubectl-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_kubectl_role.name
}
resource "aws_iam_role_policy_attachment" "eks_kubectl-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_kubectl_role.name
}
resource "aws_iam_role_policy_attachment" "eks_kubectl-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_kubectl_role.name
}

resource "kubernetes_config_map" "aws_auth_configmap" {
  metadata {
    name      = "aws-auth-poc"
    namespace = "kube-system"
  }
  data = {
    mapRoles = <<YAML
- rolearn: ${aws_iam_role.eks-node-iam.arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
- rolearn: ${aws_iam_role.eks_kubectl_role.arn}
  username: ${aws_iam_role.eks_kubectl_role.name}
  groups:
    - system:masters
YAML
  }
}