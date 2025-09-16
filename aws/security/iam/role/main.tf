resource "aws_iam_policy" "policy" {
  name   = var.policy_name
  policy = var.policy_def
}

resource "aws_iam_role" "role" {
  assume_role_policy   = var.assume_role_policy_def
  name                 = var.role_name
  max_session_duration = var.max_session_duration
}

resource "aws_iam_role_policy_attachment" "attachment" {
  policy_arn = aws_iam_policy.policy.arn
  role       = aws_iam_role.role.name
}
