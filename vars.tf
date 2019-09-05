variable "AWS_REGION" {
  default = "us-west-1"
}

variable "AWS_AZ" {
  default = "us-west-1b"
}

variable "T2_TYPE" {
  default = "t2.nano"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-west-1 = "ami-052ae783527d1a0c9"
    us-west-2 = "ami-0135f076a31aebe66"
  }
}
