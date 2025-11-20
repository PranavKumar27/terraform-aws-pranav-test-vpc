# terraform-aws-vpc

## Overview
This Terraform module creates an AWS VPC with a given CIDR
block. It also creates multiple subnets (public and private)
and for the public subnets, it also creates Internet-Gateway
and route table associations

## Usage

```

module "vpc"{
    source = "./module/vpc"

    vpc_config = {
        cidr = "10.0.0.0/16"
        name = "root-pnv-dell"
    }

    subnet_config = {
        public_subnet_pnv1 = {
            cidr = "10.0.1.0/24"
            az = "us-east-1a"
        }
        public_subnet_pnv2 = {
            cidr = "10.0.2.0/24"
            az = "us-east-1b"
            public = true
        }
        private_subnet_pnv3 = {
            cidr = "10.0.7.0/24"
            az = "us-east-1a"
        }
    }
}

```
