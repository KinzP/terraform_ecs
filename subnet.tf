# Create 2 Private Subnets
resource "aws_subnet" "private_subnet_1a_KP19" {
  vpc_id                  = aws_vpc.TF_KP19.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private subnet 1a_KP18"
  }
}
resource "aws_subnet" "private_subnet_1b_KP19" {
  vpc_id                  = aws_vpc.TF_P18.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private subnet 1b_KP18"
  }
}