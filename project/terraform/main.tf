provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "lastest_ubuntu" {
  owners      = ["409847504882"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-arm64-server-*"]
  }
}
