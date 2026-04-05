vpc = {
    cidr_block = "10.0.0.0/24"
}

public_subnets = {
  "public_a" = {
    cidr_block = "10.0.0.0/26"
    az        = "us-east-1a"
  }
  "public_b" = {
    cidr_block = "10.0.0.64/26"
    az        = "us-east-1b"
  }
}

private_subnets = {
  "private_a" = {
    cidr_block = "10.0.0.128/26"
    az        = "us-east-1a"
  }
  "private_b" = {
    cidr_block = "10.0.0.192/26"
    az        = "us-east-1b"
  }
}