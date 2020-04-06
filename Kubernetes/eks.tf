resource "aws_eks_cluster" "eks-cluster" {
  name                      = "cluster01"
  role_arn                  = aws_iam_role.eks-master-iam.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    security_group_ids      = [aws_security_group.eks_sg.id]
    subnet_ids              = aws_subnet.subnets[*].id
    endpoint_private_access = true
    endpoint_public_access  = true
  }
  tags =  {
      "Name" = "eks-cluster-001"
    }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-node-group-001"
  node_role_arn   = aws_iam_role.eks-node-iam.arn
  subnet_ids      = aws_subnet.subnets[*].id
  scaling_config {
   desired_size        = 2
   max_size            = 2
   min_size            = 1
  }
  instance_types = ["t3.medium"]
  tags =  {
      Name        = "eks-node-group-001"
    }
}

data "aws_eks_cluster_auth" "eks_author" {
  name = aws_eks_cluster.eks-cluster.id
}


