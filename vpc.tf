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
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "true"  
  tags = {
    Name = "ecomm-public-subnet-A"
  }
}

#Created pub subnet -Az- B

resource "aws_subnet" "tf-ecomm-pub-sn-B" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "ecomm-public-subnet-B"
  }
}

# Create pvt subnet -AZ- A
resource "aws_subnet" "tf-ecomm-pvt-sn-A" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "ecomm-pvt-subnet-A"
  }
}

# Create pvt subnet -AZ- B
resource "aws_subnet" "tf-ecomm-pvt-sn-B" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "ecomm-pvt-subnet-B"
  }
}

# Created internet gateway
resource "aws_internet_gateway" "tf-ecomm-igw" {
  vpc_id = aws_vpc.tf-ecomm.id

  tags = {
    Name = "internetgate_way"
  }
}

# create pubilc route table
resource "aws_route_table" "tf-ecomm-pub-rt" {
  vpc_id = aws_vpc.tf-ecomm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-ecomm-igw.id
  }
  

  tags = {
    Name = "ecomm-public-route-table"
  }
}

# create pvt route table
resource "aws_route_table" "tf-ecomm-pvt-rt" {
  vpc_id = aws_vpc.tf-ecomm.id

   tags = {
    Name = "ecomm-pvt-route-table"
  }
}

# Create public associations
resource "aws_route_table_association" "tf-ecomm-pub-asc-A" {
  subnet_id      = aws_subnet.tf-ecomm-pub-sn-A.id
  route_table_id = aws_route_table.tf-ecomm-pub-rt.id
}

resource "aws_route_table_association" "tf-ecomm-pub-asc-B" {
  subnet_id      = aws_subnet.tf-ecomm-pub-sn-B.id
  route_table_id = aws_route_table.tf-ecomm-pub-rt.id
}

#Create pvt association
# Create public associations
resource "aws_route_table_association" "tf-ecomm-pvt-asc-A" {
  subnet_id      = aws_subnet.tf-ecomm-pvt-sn-A.id
  route_table_id = aws_route_table.tf-ecomm-pvt-rt.id
}

resource "aws_route_table_association" "tf-ecomm-pvt-asc-B" {
  subnet_id      = aws_subnet.tf-ecomm-pvt-sn-B.id
  route_table_id = aws_route_table.tf-ecomm-pvt-rt.id
}
