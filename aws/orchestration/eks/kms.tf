# KMS Key for Kubernetes secret encryption
# CMK to satisfy CIS-Benchmarking requirement
# ...we still get envelope encryption, but we control it.
# By default we only allow root to manage, IAM users need to be added
data "aws_caller_identity" "current" {}

resource "aws_kms_key" "eks_master_kms" {
  description             = "An example symmetric encryption KMS key"
  enable_key_rotation     = true
  deletion_window_in_days = 20
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "user-key-admin-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}
