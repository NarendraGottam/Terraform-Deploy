variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image (AMI) for EC2"
  type        = string
  default     = "ami-091f18e98bc129c4e"
}

variable "s3_bucket_name" {
  description = "S3 bucket for Terraform state storage"
  type        = string
  default     = "terraform-state-bucket-gopi"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for state locking"
  type        = string
  default     = "terraform-lock-table"
}

