variable "cidr_block" {
  type        = string
  description = "name of vpc cidr"
  default     = "10.0.0.0/16"
}


variable "public1-cidr" {
  type        = string
  description = "name of public subnet 1 cidr"
  default     = "10.0.1.0/24"

}

variable "public2-cidr" {
  type        = string
  description = "name of public subnet 2 cidr"
  default     = "10.0.2.0/24"

}


variable "public3-cidr" {
  type        = string
  description = "name of public subnet 3 cidr"
  default     = "10.0.3.0/24"

}

variable "private1-cidr" {
  type        = string
  description = "name of private subnet 1 cidr"
  default     = "10.0.4.0/24"

}

variable "private2-cidr" {
  type        = string
  description = "name of private subnet 2 cidr"
  default     = "10.0.5.0/24"

}


variable "az1" {
  type        = string
  description = "name of availability zone"
  default     = "eu-west-1a"

}

variable "az2" {
  type        = string
  description = "name of availability zone"
  default     = "eu-west-1b"

}

variable "region-name" {
  type        = string
  description = "name of region"
  default     = "eu-west-1"

}