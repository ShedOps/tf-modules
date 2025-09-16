resource "aws_iam_user" "user" {
  name          = var.user_name
  path          = var.user_path
  force_destroy = "true"
}

resource "aws_iam_user_policy" "policy" {
  count  = var.attach_policy ? 1 : 0
  policy = var.user_policy
  user   = aws_iam_user.user.name
}

resource "aws_iam_group_membership" "group" {
  count = var.attach_group ? 1 : 0
  name  = "tf-testing-group-membership"

  users = [
    aws_iam_user.user.name
  ]

  group = var.user_group
}
