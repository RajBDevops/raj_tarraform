#Create VPC
resource "aws_vpc" "tf-ecomm" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "e-comm-vpc"
  }
}

# Create public subnet -AZ- A
resource "aws_subnet" "tf-ecomm-pub-sn-A" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "10.0.0.0/24"
availability_zone = "us-east-2"
  tags = {
    Name = "ecomm-public-subnet-A"
  }
}

