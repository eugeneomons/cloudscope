resource "aws_vpc" "cloudscope" {

  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true

  enable_dns_support = true

  tags = merge(var.common_tags, {

  Name = "${var.project_name}-vpc" })

}

resource "aws_subnet" "cloudscope_public" {
  vpc_id                  = aws_vpc.cloudscope.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags                    = merge(var.common_tags, { Name = "${var.project_name}-public-subnet" })
}

resource "aws_internet_gateway" "cloudscope_igw" {
  vpc_id = aws_vpc.cloudscope.id
  tags   = merge(var.common_tags, { Name = "${var.project_name}-igw" })
}

resource "aws_route_table" "cloudscope_rt_public" {
  vpc_id = aws_vpc.cloudscope.id
  tags   = merge(var.common_tags, { Name = "${var.project_name}-rt" })
}
resource "aws_route" "cloudscope_public_internet" {
  route_table_id         = aws_route_table.cloudscope_rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.cloudscope_igw.id
}
resource "aws_route_table_association" "cloudscope_rta" {
  route_table_id = aws_route_table.cloudscope_rt_public.id
  subnet_id      = aws_subnet.cloudscope_public.id
}

resource "aws_security_group" "cloudscope_sg" {
  name        = "cloudscope_ec2_sg"
  description = "Allow inbound traffic on SSH and HTTP and all outbound traffic"
  vpc_id      = aws_vpc.cloudscope.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_public_ip]
    description = "SSH traffic"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Traffic"
  }
  tags = merge(var.common_tags, { Name = "${var.project_name}-public-sg" })
}
