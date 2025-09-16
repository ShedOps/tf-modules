output "group_arn" {
  value = aws_iam_group.group[*].arn
}

output "group_id" {
  value = aws_iam_group.group[*].id
}
