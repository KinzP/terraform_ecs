# Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
resource "aws_ecs_cluster" "cluster" {
  name = "KP19-ecs-cluster"
  
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
  resource "aws_ecs_cluster_capacity_providers" "cluster" {
    cluster_name = aws_ecs_cluster.cluster.name
  
    capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }
}

module "ecs-fargate" {
  source = "umotif-public/ecs-fargate/aws"
  version = "~> 6.1.0"

  name_prefix        = "ecs-fargate-KP19"
  vpc_id             = aws_vpc.TF_KP192.id
  private_subnet_ids = [aws_subnet.private_subnet_1a_KP19.id, aws_subnet.private_subnet_1b_KP19.id]

  cluster_id         = aws_ecs_cluster.cluster.id

  task_container_image   = "centos"
  task_definition_cpu    = 256
  task_definition_memory = 512

  task_container_port             = 80
  task_container_assign_public_ip = true

  target_groups = [
    {
      target_group_name = "tg-fargate-KP19"
      container_port    = 80
    }
  ]

  health_check = {
    port = "traffic-port"
    path = "/"
  }

  tags = {
    Environment = "test"
    Project = "Test"
  }

   load_balanced = false
}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
provider "docker" {}