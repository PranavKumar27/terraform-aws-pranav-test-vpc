This is a complete Config Terraform for VPC

```
provider "aws"{
    region = "us-east-1"
}

module "vpc"{
    source = "./module/vpc"

    vpc_config = {
        cidr_block = "10.0.0.0/16"
        name = "root-pnv-dell"
    }

    subnet_config = {
        public_subnet_pnv1 = {
            cidr_block = "10.0.2.0/24"
            az = "us-east-1b"
            public = true
        }
        private_subnet_pnv4 = {
            cidr_block = "10.0.7.0/24"
            az = "us-east-1a"
        }
    }
}
```