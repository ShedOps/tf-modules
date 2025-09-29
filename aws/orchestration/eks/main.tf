# Looks up our public ip on the fly
# This will be used to lock down API access
data "http" "my_public_ip" {
  url = "https://checkip.amazonaws.com"
  request_headers = {
    Accept = "text/plain"
  }
}

# chmop() removes any trailing newline from our response
# /32 makes it a single-host CIDR block
locals {
  my_public_ip = "${chomp(data.http.my_public_ip.response_body)}/32"
}

resource "aws_eks_cluster" "example" {
  name = "example"

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = false
  }

  role_arn = aws_iam_role.cluster.arn
  version  = "1.31"

  # We will use CMK (KMS) for secret encryption at rest
  # ...which satisfies the CIS Benchmark requirements
  encryption_config {
    provider {
      key_arn = aws_kms_key.eks_master_kms.arn
    }
    resources = [
      "secrets"
    ]
  }

  # We pass only private subnets to vpc_config (control-plane ENIs live here)
  # Public subnets are discovered by the AWS LB Controller via tags
  # Our VPC module outputs are maps (keyed by AZ). We need to wrap with values here
  # ...as vpc_config subnet_ids is expecting a list (in 2 x different AZs, minimum).
  vpc_config {
    endpoint_private_access = true # Worker Nodes in private subnets MUST have this set to true
    endpoint_public_access  = true

    # Lock down to our previously resolved client (public) ip
    # where terraform apply was executed
    public_access_cidrs = [
      local.my_public_ip
    ]

    subnet_ids = toset(values(data.terraform_remote_state.sandbox_vpc.outputs.default_private_subnet_ids))
  }

  enabled_cluster_log_types = [
    "audit",             # Users, admins or system component audit logs / who did what
    "authenticator",     # Control Plane RBAC auth using IAM creds (unique to EKS) / IAM to k8s login events
    "api",               # Control Plane components that exposes the K8s API / API server's health / requests
    "controllerManager", # Manages core control loops (makes sure deployments, replicasets, endpoints match the desired state)
    "scheduler"          # Managed when & where to run pods in our cluster (useful for ts pod states, eg pending)
  ]

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

resource "aws_iam_role" "cluster" {
  name = "eks-cluster-example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}
