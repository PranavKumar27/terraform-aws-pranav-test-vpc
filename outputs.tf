output "vpc_id"{
    description = "VPC_id"
    value = aws_vpc.pnv_vpc.id
}

locals {
    public_subnet_pnv1 = {
        for key,config in local.public_subnets: key => {
            subnet_id = aws_subnet.pnv_subnets[key].id
            az = aws_subnet.pnv_subnets[key].availability_zone
        }
    }

    private_subnet_pnv3 = {
        for key,config in local.private_subnets: key => {
            subnet_id = aws_subnet.pnv_subnets[key].id
            az = aws_subnet.pnv_subnets[key].availability_zone
        }
    }
}

output "public_subnets_list" {
  value = local.public_subnet_pnv1
}

output "private_subnets_list" {
  value = local.private_subnet_pnv3
}