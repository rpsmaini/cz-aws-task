variable "vpc-id" {
  description = "test value"
}

variable "vpc_public_subnets" {
    type = set(string)
}

variable "asg-id" {
  description = "for asg gruop name"
}
