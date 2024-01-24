provider "aws" {
  region  = "us-east-1"
  access_key = ""
  secret_key = ""
}


# 1.Create vpc
resource "aws_vpc" "project_vpc" {
  cidr_block = "10.0.0.0/16"

   tags = {
    Name = "Project-1"
  }
}

# 2.Create Internet Gateway

resource "aws_internet_gateway" "project_gw" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    Name = "Project-1"
  }
}
# 3.Create custom Route table

resource "aws_route_table" "project_route_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.project_gw.id
  }

  tags = {
    Name = "Project-1"
  }
}

# 4.Create a subnet

resource "aws_subnet" "project_subnet" {
  vpc_id     = aws_vpc.project_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Project-1"
  }
}

# 5.Associate subnet with route table

resource "aws_route_table_association" "project_a" {
  subnet_id      = aws_subnet.project_subnet.id
  route_table_id = aws_route_table.project_route_table.id
}


# 6.Create security group to allow port 22, 80 , 443


resource "aws_security_group" "project_sec_grp" {
  name        = "allow_web"
  description = "Allow web inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.project_vpc.id

  tags = {
    Name = "project-1"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.project_sec_grp.id
  cidr_ipv4 = aws_vpc.project_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


# 7.create a network interface with an ip in the subnet that was created in step 4

resource "aws_network_interface" "project_network_interface" {
  subnet_id       = aws_subnet.project_subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.project_sec_grp.id]    
 tags = {
  Name ="Project-1"
 }
}

# 8. Assign an elastic ip to the network interface creted in step 7


resource "aws_eip" "one" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.project_network_interface.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [ aws_internet_gateway.project_gw ]

   tags = {
  Name ="Project-1"
 }

}
# 9. Create ubuntu server 

resource "aws_instance" "my-first-server" {
  ami           ="ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
    tags = {
    Name = "project-1"
  }
  }