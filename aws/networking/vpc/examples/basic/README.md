# Example barebones VPC, subnets, routing, IGW/NATGWs and NACLs for a web tier application

Web Tier exists in the public subnets and routing is allowed ingress from
the internet on TCP/80 / TCP/443 with egress

Private subnets are alllowed to talk within the VPC, but not outside
 of this context

##

To create the VPC:

1. cp terraform.tfvars.example terraform.tfvars
2. terraform init
3. terraform apply

Some points:

a) We use local backend for S3 state, as its an example :) in prod environments
we would use S3 and dynamodb

b) This will create a VPC with flow logs disabled

c) This is locked down, tweak as you like for internet outbound access,
patching / updates etc

To destroy the VPC:

1. terraform destroy
