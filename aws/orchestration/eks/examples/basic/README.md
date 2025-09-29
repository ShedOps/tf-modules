# Example basic EKS Cluster

## Uses IAM User and Role Authentication for EKS

### Steps (⚠️ Note: There IS a charge to deploying AWS infrastructure and services ⚠️)

1. Using terraform, deploy example basic VPC, from aws/networking/vpc/examples/basic folder
2. Deploy the basic EKS example, from this folder
3. Attach the "Developers" Group (in IAM) to a user of your choice
4. Execute the following from the CLI, as that user:
```
aws eks update-kubeconfig \                                           
    --region eu-west-1 \
    --name example \
    --role-arn arn:aws:iam::your_aws_account_id:role/EKS-Auditors-Role
```
6. Now you should have the "Auditors" permissions, verify by executing (as an example):
```
kubectl get configmaps
```
7. See: https://docs.aws.amazon.com/eks/latest/userguide/access-policies.html
