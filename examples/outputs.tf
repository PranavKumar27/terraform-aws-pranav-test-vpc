output "vpc"{
    value = module.vpc.vpc_id
    description = "VPC ID Values"
}

output "public_subnets"{
    value = module.vpc.public_subnets_list
    description = "Public Subnets PNV"
}

output "private_subnets"{
    value = module.vpc.private_subnets_list
    description = "Private Subnets PNV"
}