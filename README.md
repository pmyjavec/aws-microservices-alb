# AWS Microservices ALB

[![CircleCI](https://circleci.com/gh/paidy/aws-microservices.svg?style=svg&circle-token=94d3443ecbd4502eef2de6062f5c93f45ab976ec)](https://circleci.com/gh/paidy/aws-microservices)

Terraform and configuration management code to manage the deployment of
Gateway Microservices on AWS.

Running Terraform.

```
$ terraform plan -out plan
$ terraform apply plan
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment |  | string | n/a | yes |
| environment\_quality |  | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dns\_name | The DNS name of the load balancer. |
| http\_tcp\_listener\_arns | The ARN of the TCP and HTTP load balancer listeners created. |
| http\_tcp\_listener\_ids | The IDs of the TCP and HTTP load balancer listeners created. |
| https\_listener\_arns | The ARNs of the HTTPS load balancer listeners created. |
| https\_listener\_ids | The IDs of the load balancer listeners created. |
| load\_balancer\_arn\_suffix | ARN suffix of our load balancer - can be used with CloudWatch. |
| load\_balancer\_id | The ID and ARN of the load balancer we created. |
| load\_balancer\_zone\_id | The zone_id of the load balancer to assist with creating DNS records. |
| target\_group\_arn\_suffixes | ARN suffixes of our target groups - can be used with CloudWatch. |
| target\_group\_arns | ARNs of the target groups. Useful for passing to your Auto Scaling group. |
| target\_group\_names | Name of the target group. Useful for passing to your CodeDeploy Deployment Group. |

