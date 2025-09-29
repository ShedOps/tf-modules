# Example barebones VPC, subnets, routing, IGW/NATGWs and NACLs

## Traffic allowed freely

To create the VPC:

1. cp terraform.tfvars.example terraform.tfvars
2. terraform init
3. terraform apply

Some points:

a) We use local backend for S3 state, as its an example :) in prod environments
we would use S3 and dynamodb

b) This will create 2 x subnets: Private and Public

c) This will create a VPC with flow logs disabled

d) This is NOT locked down by default, tweak as you like for internet outbound access,
patching / updates etc

To destroy the VPC:

1. terraform destroy
