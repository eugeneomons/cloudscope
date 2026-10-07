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