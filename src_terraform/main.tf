
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = var.aws_vpc_name
  cidr = var.aws_vpc_cidr

  azs             = var.aws_vpc_azs
  private_subnets = var.aws_vpc_private_subnets
  public_subnets  = var.aws_vpc_public_subnets
  
  enable_nat_gateway = true
  enable_vpn_gateway = true
  
  enable_dns_hostnames = true
  enable_dns_support = true

  
  tags = merge(var.aws_project_tags, {
    "kubernetes.io/cluster/${var.aws_eks_name}" = "shared"
  })

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.aws_eks_name}" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.aws_eks_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = 1
  }
}

module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "20.14.0"
  cluster_name                             = var.aws_eks_name
  cluster_version                          = var.aws_eks_version
  enable_cluster_creator_admin_permissions = true
  subnet_ids                               = module.vpc.private_subnets
  vpc_id                                   = module.vpc.vpc_id
  cluster_endpoint_public_access           = true
  
  eks_managed_node_groups = {
    Apps-Send-Received = {
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      instance_types = var.aws_eks_managed_node_groups_instance_types
      tags           = var.aws_project_tags
      #novas alterações
      public_ip      = true
      cluster_endpoint_public_access = true
      public_subnets = module.vpc.public_subnets
    
    } 
  ingress= {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress= {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress= {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #rabbitmq
  ingress= {
    from_port   = 15672
    to_port     = 15672
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #minio
  ingress= {
    from_port   = 9001
    to_port     = 9001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #redis
  ingress= {
    from_port   = 8001
    to_port     = 8001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress= {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    
  }
  tags = var.aws_project_tags
}