
# Terraform-Driven AWS VPC, Subnet, and EC2 Instance Setup

This Terraform script automates the process of creating a Virtual Private Cloud (VPC) in AWS, setting up a subnet, and launching an EC2 instance within the VPC.

## Prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- AWS credentials configured with the necessary permissions.

## Update Terraform Variables:

- Open the **main.tf** file and replace the following variables with your desired values:

- **region**: AWS region where resources will be created.
- **availability_zone**: Desired availability zone for the subnet.
- **ec2_instance_ami** : The AMI ID for the Ubuntu server.

  ## Steps included in the project


- Create a vpc in aws cloud
- Create Internet Gateway
- Creating a custom route table
- Creating a subnet
- Associate subnet with Route table
- Create security group 
- Creating a network interface
- Assign an elastic IP to the network interface
- Create an EC2 Instance - Ubuntu server


