resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn    = aws_iam_role.vpc_flow_logs_iam_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_logs_cwlg.arn
  traffic_type    = "ALL"
  vpc_id          = var.cfg.vpc_id
}

resource "aws_cloudwatch_log_group" "vpc_flow_logs_cwlg" {
  name = var.cfg.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc_flow_logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "vpc_flow_logs_iam_role" {
  name               = var.cfg.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "vpc_flow_logs_iam_policy_doc" {
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

resource "aws_iam_role_policy" "vpc_flow_logs_iam_role_policy" {
  name   = var.cfg.name
  role   = aws_iam_role.vpc_flow_logs_iam_role.id
  policy = data.aws_iam_policy_document.vpc_flow_logs_iam_policy_doc.json
}

variable "cfg" {
  type = object({
    vpc_id = string
    name   = string
  })
}
