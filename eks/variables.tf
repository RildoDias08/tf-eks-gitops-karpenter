variable "project_name" {
  type = string
}

variable "vpc" {
  type = string
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string   
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string   
  }))
}

variable "ecr_repo" {
  type = list(string)
  default = ["app-back", "app-front"]
}