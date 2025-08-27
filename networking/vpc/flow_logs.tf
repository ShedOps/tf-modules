module "vpc_flow_logs" {
  source   = "./submodules/flow_logs"
  count    = var.enable_flow_logs ? 1 : 0

  cfg = {
    vpc_id = aws_vpc.sandbox.id
    name   = var.name
  }
}
