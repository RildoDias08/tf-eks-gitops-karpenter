variable "ecr_repo" {
  type = list(string)
  default = ["app/backend", "app/frontend"]
}