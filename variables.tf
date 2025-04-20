variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
  default     = "cz"

}

variable "aws_region" {
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

