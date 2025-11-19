# Local, because this is in an example
# Outside of example context, use S3
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
