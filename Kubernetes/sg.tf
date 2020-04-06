resource "aws_security_group" "eks_sg" {
  name        = "sgeks"
  description = "EKS Security Group"
  vpc_id      = aws_vpc.vpc.id
}
resource "aws_security_group_rule" "egress_default_EKS" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_sg.id
}
resource "aws_security_group_rule" "allow_all_eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.eks_sg.id
  security_group_id        = aws_security_group.eks_sg.id
}
#resource "aws_security_group_rule" "ingress_default_eks" {
#  for_each                  = var.allowed_security_groups
#
#  type                     = "ingress"
#  from_port                = 0
#  to_port                  = 65535
#  protocol                 = "-1"
#  security_group_id        = aws_security_group.eks_sg.id
#  source_security_group_id  = each.value
#}