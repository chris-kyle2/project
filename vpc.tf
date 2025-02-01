module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = var.VPC_NAME
  cidr                 = var.VpcCIDR
  azs                  = [var.Zone1]
  public_subnets       = [var.PubSub1CIDR]
  private_subnets      = [var.PrivSub1CIDR]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Terraform   = "true"
    Environment = "Prod"
  }
  vpc_tags = {
    name = var.VPC_NAME
  }
}
