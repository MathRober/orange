#provider "helm" {
#  kubernetes {
#      host                   = aws_eks_cluster.eks-cluster.endpoint
#      cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster.certificate_authority.0.data)
#      token                  = data.aws_eks_cluster_auth.eks_author.token
#      load_config_file = false
#  }
#}
#
#provider "kubernetes" {
#
#  host                   = aws_eks_cluster.eks-cluster.endpoint
#  cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster.certificate_authority.0.data)
#  token                  = data.aws_eks_cluster_auth.eks_author.token
#
#  load_config_file = false
#  version = "~> 1.11.0"
#}

