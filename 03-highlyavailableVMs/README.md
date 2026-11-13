
# Project 2 - Highly Available NGINX Web Servers on Azure

## Project Objective

Deploy two Ubuntu Linux virtual machines running NGINX behind an Azure Standard Load Balancer using Terraform.

## Architecture

- Azure Resource Group
- Azure Virtual Network and Subnet
- Network Security Group
- Two Ubuntu Linux VMs
- NGINX web server
- Standard Public Load Balancer
- Backend Pool
- HTTP Health Probe
- HTTP Load Balancing Rule
- Outbound Rule

## Technologies

- Microsoft Azure
- Terraform
- Ubuntu Linux
- NGINX
- Azure Load Balancer
- Cloud-init

## Deployment

1. Configure Azure authentication.
2. Set the administrator password using TF_VAR_admin_password.
3. Run terraform init.
4. Run terraform fmt.
5. Run terraform validate.
6. Run terraform plan.
7. Run terraform apply.

## Testing

- Access the website through the Load Balancer public IP.
- Identify responses from both backend VMs.
- Stop NGINX on one VM.
- Verify that the other healthy VM continues serving requests.
- Restart NGINX and verify recovery.

## Security

- No public IPs assigned to individual VMs.
- HTTP traffic is routed through the Load Balancer.
- Network Security Group controls inbound traffic.
- Terraform state and passwords are excluded from Git.

## Cleanup

Run terraform destroy after completing the lab.
