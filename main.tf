resource "aws_vpc" "pnv_vpc"{
    cidr_block = var.vpc_config.cidr
    tags = {
      Name = var.vpc_config.name
    }
}

resource "aws_subnet" "pnv_subnets"{
    vpc_id = aws_vpc.pnv_vpc.id

    for_each = var.subnet_config
    cidr_block = each.value.cidr
    availability_zone = each.value.az 
    tags = {
        Name = each.key
    }
}

locals {
    public_subnets = {
        for key,val in var.subnet_config : key => val if val.public == true
    }

    private_subnets = {
        for key,val in var.subnet_config : key => val if val.public != true
    }
}

resource "aws_internet_gateway" "pnv_igw" {
  vpc_id = aws_vpc.pnv_vpc.id
  count = length(local.public_subnets) > 0 ? 1: 0
}

resource "aws_route_table" "pnv_route_table" {
  vpc_id = aws_vpc.pnv_vpc.id
  count = length(local.public_subnets) > 0 ? 1 : 0
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pnv_igw[0].id
  }
}

resource "aws_route_table_association" "pnv_table_assoction" {
  
  for_each = local.public_subnets
  subnet_id = aws_subnet.pnv_subnets[each.key].id
  route_table_id = aws_route_table.pnv_route_table[0].id
}