resource "aws_iam_group" "group" {
  name = var.group_name
  path = var.group_path
}

resource "aws_iam_group_policy" "group_policy" {
  name  = var.group_name
  group = aws_iam_group.group.name

  policy = var.group_policy
}
