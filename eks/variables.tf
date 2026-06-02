variable "ecr_repo" {
  type    = list(string)
  default = ["app/backend", "app/frontend"]
}

variable "region" {
  type    = string
  default = "us-east-1"
}