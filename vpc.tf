resource "aws_vpc" "TF_KP19" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "VPC for ecs_KP19"
  }
}