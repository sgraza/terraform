## Terraform : Infrastructure as code

Using terraform to create infrastrucutre on AWS using code. In this code, we are trying to create a below items:

1. VPC
2. Public Subnet inside VPC
3. Internet Gateway associated with VPC
4. Route Table to Internet Gateway
5. Security Group inside VPC
6. Key Pair used for SSH access
7. EC2 Instance inside our public subnet with an associated security group and generated a key pair

# Create private and public key using Openssl

```
openssl genrsa -out kp_devops.pem 1024
ssh-keygen -y -f kp_devops.pem > kp_devops.pub
```

# Step to run the terraform configuration:

1. Initialize a Terraform working directory

```
terraform init
```

2. Generate and show an execution plan

```
terraform plan -var-file=variables.tfvars
```

3. Builds or changes infrastructure

```
terraform apply -var-file=variables.tfvars
```

4. To delete the infrastructure

```
terraform destroy -var-file=variables.tfvars
```

Note: You can update/add variables in variables.tfvars file.
