data "terraform_remote_state" "sandbox_vpc" {
  backend = "local"

  config = {
    path = abspath("${path.module}/../../networking/vpc/examples/basic/terraform.tfstate")
  }
}
