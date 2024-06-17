variable "aws_region" {
  description = "Região da AWS para provisionar os recursos"
  type        = string
  default     = "us-east-1"
}
variable "aws_vpc_name" {
  description = "VPC name da AWS"
  type        = string
  nullable    = false
}
variable "aws_vpc_cidr" {
  description = "VPC CIDR name da AWS"
  type        = string
  nullable    = false
}
variable "aws_vpc_azs" {
  description = "VPC AZs name da AWS"
  type        = set(string)
  nullable    = false
}
variable "aws_vpc_private_subnets" {
  description = "VPC private subnets name da AWS"
  type        = set(string)
  nullable    = false
}
variable "aws_vpc_public_subnets" {
  description = "VPC public subnets name da AWS"
  type        = set(string)
  nullable    = false
}
variable "aws_eks_name" {
  description = "EKS name da AWS"
  type        = string
  nullable    = false
}
variable "aws_eks_version" {
  description = "Eks version name da AWS"
  type        = string
  nullable    = false
}
variable "aws_eks_managed_node_groups_instance_types" {
  description = "eks managed node groups instance types"
  type        = set(string)
  nullable    = false
}
variable "aws_access_key" {
  description = "Access Key ID da AWS"
  type        = string
}
variable "aws_project_tags" {
  description = "Tags do projeto"
  type        = map(any)
  nullable    = false
}
variable "aws_secret_key" {
  description = "Secret Access Key da AWS"
  type        = string
}

variable "bucket_name" {
  description = "Nome único do Bucket S3"
  type        = string
}
