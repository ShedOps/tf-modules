resource "aws_eks_access_entry" "auditors_ae" {
  cluster_name      = module.eks_cluster.eks_cluster_name
  principal_arn     = aws_iam_role.eks_auditor_role.arn
  kubernetes_groups = []
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "auditors_apa" {
  cluster_name  = module.eks_cluster.eks_cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
  principal_arn = aws_iam_role.eks_auditor_role.arn

  access_scope {
    type = "cluster"
    #    namespaces = ["example-namespace"]
  }
}
