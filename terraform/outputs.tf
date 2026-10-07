output "vpc_id" {

  value = aws_vpc.cloudscope.id

}

output "public_subnet_id" {
  value = aws_subnet.cloudscope_public.id

}

output "internet_gateway_id" {
  value = aws_internet_gateway.cloudscope_igw.id
}
