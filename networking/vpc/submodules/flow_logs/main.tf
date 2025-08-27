resource "aws_flow_log" "vpc-flow-log" {
  iam_role_arn    = aws_iam_role.vpc-flow-logs-iam-role.arn
  log_destination = aws_cloudwatch_log_group.vpc-flow-logs-cwlg.arn
  traffic_type    = "ALL"
  vpc_id          = var.cfg.vpc_id
}

resource "aws_cloudwatch_log_group" "vpc-flow-logs-cwlg" {
  name = var.cfg.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "vpc-flow-logs-iam-role" {
  name               = var.cfg.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "vpc-flow-logs-iam-policy-doc" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "vpc-flow-logs-iam-role-policy" {
  name   = var.cfg.name
  role   = aws_iam_role.vpc-flow-logs-iam-role.id
  policy = data.aws_iam_policy_document.vpc-flow-logs-iam-policy-doc.json
}

variable "cfg" {
  type   = object({
  vpc_id = string
  name   = string
  })
}
