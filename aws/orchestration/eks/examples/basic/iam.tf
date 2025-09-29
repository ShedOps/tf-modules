locals {
  account_id = data.aws_caller_identity.current.id
}

resource "aws_iam_group" "auditors" {
  name = "Auditors"
}

resource "aws_iam_group" "devteam" {
  name = "DevTeam"
}

resource "aws_iam_group" "platform_admins" {
  name = "PlatformAdmins"
}

resource "aws_iam_role" "eks_auditor_role" {
  name = "EKS-Auditors-Role"

  # This is the trust policy (the "assume permissions").
  # It specifies WHO can assume this role. Here, we allow any principal
  # in the root of the account to assume it, IF they have the sts:AssumeRole permission.
  # They still need a policy to give them permission to assume this role.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${local.account_id}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  description = "Role for auditors to gain view-only access to the EKS cluster."
}

# Now, we create the policy that allows assuming the role
resource "aws_iam_policy" "allow_assume_eks_auditor_role" {
  name        = "Allow-Assume-EKS-Auditor-Role"
  description = "Allows assuming the EKS Auditor Role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = aws_iam_role.eks_auditor_role.arn # The ARN of the role from Step 1
      }
    ]
  })
}

# Finally, we attach the policy to the group
resource "aws_iam_group_policy_attachment" "auditors_can_assume_eks_role" {
  group      = aws_iam_group.auditors.name
  policy_arn = aws_iam_policy.allow_assume_eks_auditor_role.arn
}
