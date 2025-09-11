variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.large"
}

variable "ami_id" {
  description = "AMI "
  type        = string
  default     = "ami-04f59c565deeb2199" 
}

variable "key_name" {
  description = "AWS key pair name to SSH into the instance"
  type        = string
  default     = "tusharnv" # 🔧 replace with your key pair name
}
variable "runner_token" {
  description = "GitHub token for runner registration"
  type        = string
  sensitive   = true
}
