provider "aws" {
  region = "us-east-1"
}

# Use existing VPC and subnets
data "aws_vpc" "selected" {
  id = "vpc-045409f9dc02cd4e1"
}

data "aws_subnet" "public1" {
  id = "subnet-0a37cf861b1a56e2b"
}

data "aws_subnet" "public2" {
  id = "subnet-0303a79a44a64c950"
}
