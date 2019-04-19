/**
# AWS Microservices ALB

[![CircleCI](https://circleci.com/gh/paidy/aws-microservices.svg?style=svg&circle-token=94d3443ecbd4502eef2de6062f5c93f45ab976ec)](https://circleci.com/gh/paidy/aws-microservices)

Terraform and configuration management code to manage the deployment of
Gateway Microservices on AWS.

Running Terraform.

```
$ terraform plan -out plan
$ terraform apply plan
```
*/

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "terraform_remote_state" "microservices" {
  backend = "s3"

  config {
    key = "microservices/${var.environment}"

    region = "ap-northeast-1"
    bucket = "paidy-terraform-state-${var.environment_quality}"
  }
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "3.5.0"

  # insert the 4 required variables here
  load_balancer_name = "microservices-01"
  subnets            = "${data.terraform_remote_state.microservices.public_subnets}"
  vpc_id             = "${data.terraform_remote_state.microservices.vpc_id}"
  security_groups    = ["${aws_security_group.default.id}"]
}

resource "aws_security_group" "default" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${data.terraform_remote_state.microservices.vpc_id}"
}

resource "aws_security_group_rule" "http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "https" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "allow_all" {
  type        = "egress"
  to_port     = 0
  protocol    = "-1"
  from_port   = 0
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.default.id}"
}
