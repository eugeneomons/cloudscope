variable "aws_region" {

  description = "AWS region for CloudScope"

  type = string

}

variable "project_name" {

  description = "Project name"

  type = string

}

variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "availability_zone" {
  type = string
}