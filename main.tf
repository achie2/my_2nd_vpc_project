# Creating networking for the project


resource "aws_vpc" "Eng_Palago" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "Eng_Palago"
  }
}


# Public Subnet 1 


resource "aws_subnet" "prod_pub_sub1" {
  vpc_id            = aws_vpc.Eng_Palago.id
  cidr_block        = var.public1-cidr
  availability_zone = var.az1



  tags = {
    Name = "prod_pub_sub1"
  }
}


# Public Subnet 2


resource "aws_subnet" "prod_pub_sub2" {
  vpc_id            = aws_vpc.Eng_Palago.id
  cidr_block        = var.public2-cidr
  availability_zone = var.az1



  tags = {
    Name = "prod_pub_sub2"
  }
}


# Public subnet 3

resource "aws_subnet" "prod_pub_sub3" {
  vpc_id            = aws_vpc.Eng_Palago.id
  cidr_block        = var.public3-cidr
  availability_zone = var.az2



  tags = {
    Name = "prod_pub_sub3"
  }
}


# Private Subnet 1


resource "aws_subnet" "prod_priv_sub1" {
  vpc_id            = aws_vpc.Eng_Palago.id
  cidr_block        = var.private1-cidr
  availability_zone = var.az1



  tags = {
    Name = "prod_priv_sub1"
  }
}


# Private Subnet 2


resource "aws_subnet" "prod_priv_sub2" {
  vpc_id            = aws_vpc.Eng_Palago.id
  cidr_block        = var.private2-cidr
  availability_zone = var.az2



  tags = {
    Name = "prod_priv_sub2"
  }
}

# Public route table

resource "aws_route_table" "prod_pub_route_table" {
  vpc_id = aws_vpc.Eng_Palago.id



  tags = {
    Name = "prod_pub_route_table"
  }
}



# Private route table

resource "aws_route_table" "prod_priv_route_table" {
  vpc_id = aws_vpc.Eng_Palago.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Prod_Nat_gateway.id
  }



  tags = {
    Name = "prod_priv_route_table"
  }
}




# Associate public subnets with the public route table


resource "aws_route_table_association" "pub_sub1_route_assoc" {
  subnet_id      = aws_subnet.prod_pub_sub1.id
  route_table_id = aws_route_table.prod_pub_route_table.id
}

resource "aws_route_table_association" "pub_sub2_route_assoc" {
  subnet_id      = aws_subnet.prod_pub_sub2.id
  route_table_id = aws_route_table.prod_pub_route_table.id
}


resource "aws_route_table_association" "pub_sub3_route_assoc" {
  subnet_id      = aws_subnet.prod_pub_sub3.id
  route_table_id = aws_route_table.prod_pub_route_table.id
}


# Associate private subnets with the private route table

resource "aws_route_table_association" "priv_sub1_route_assoc" {
  subnet_id      = aws_subnet.prod_priv_sub1.id
  route_table_id = aws_route_table.prod_priv_route_table.id
}


resource "aws_route_table_association" "priv_sub2_route_assoc" {
  subnet_id      = aws_subnet.prod_priv_sub2.id
  route_table_id = aws_route_table.prod_priv_route_table.id
}


# Allocate elastic ip address for the Nat gateway

resource "aws_eip" "eip_for_nat_gateway" {
  vpc = true
  tags = {
    Name = "eip-for-nat-gateway"
  }
}



# Creating Nat gateway


resource "aws_nat_gateway" "Prod_Nat_gateway" {
  allocation_id = aws_eip.eip_for_nat_gateway.id
  subnet_id     = aws_subnet.prod_pub_sub1.id

  tags = {
    Name = "Prod-Nat-gateway"
  }

}



# Internet Gateway


resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.Eng_Palago.id


  tags = {
    Name = "Prod-igw"
  }
}


# Associate the internet gateway to the public route table


resource "aws_route" "Prod-igw-association" {
  route_table_id         = aws_route_table.prod_pub_route_table.id
  gateway_id             = aws_internet_gateway.Prod-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
