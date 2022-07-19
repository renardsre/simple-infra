variable "ami_id" {
  type    = string
  default = ""
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "count_instances" {
  type    = number
  default = null
}

variable "machine_type" {
  type    = string
  default = ""
}

variable "subnet_id" {
  type    = string
  default = ""
}

variable "key_name" {
  type    = string
  default = ""
}

variable "create_key" {
  type    = string
  default = ""
}

variable "public_key" {
  type    = string
  default = ""
}

variable "instance_name" {
  type    = string
  default = ""
}

variable "environment" {
  type    = string
  default = ""
}

variable "sg_name" {
  type    = string
  default = ""
}

variable "security_group_ids" {
  type    = string
  default = ""
}

variable "private_ip" {
  type    = list(any)
  default = []
}

variable "public_ip" {
  type    = bool
  default = false
}

variable "elastic_ip" {
  type    = bool
  default = false
}

variable "volume_type" {
  type    = string
  default = ""
}

variable "volume_size" {
  type    = number
  default = null
}

variable "script_location" {
  type    = string
  default = ""
}

variable "ami_os" {
  type    = string
  default = ""
}
