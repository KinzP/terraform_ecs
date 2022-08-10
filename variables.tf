# VPC variable

variable "vpc_cidr" {
  description = "CIDR range of VPC"
  type        = string
  default     = "10.0.0.0/16"
}