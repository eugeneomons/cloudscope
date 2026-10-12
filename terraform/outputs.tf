output "vpc_id" {

  value = aws_vpc.cloudscope.id

}

output "public_subnet_id" {
  value = aws_subnet.cloudscope_public.id

}

output "internet_gateway_id" {
  value = aws_internet_gateway.cloudscope_igw.id
}

output "route_table_id" {
  value = aws_route_table.cloudscope_rt_public.id
}

output "cloudscope_public_ip" {
  value = aws_instance.cloudscope_api.public_ip
}

output "cloudscope_instance_id" {
  value = aws_instance.cloudscope_api.id
}

output "cloudscope_public_dns" {
    value = aws_instance.cloudscope_api.public_dns
}