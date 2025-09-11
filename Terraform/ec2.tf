resource "aws_instance" "test_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "tusharnv"

  user_data     = templatefile("${path.module}/Setup_script.sh", { runner_token = var.runner_token })

  tags = {
    Name = "tush-instance"
  }
}