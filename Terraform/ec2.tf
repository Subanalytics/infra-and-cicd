variable "runner_token" {
  description = "GitHub token for runner registration"
  type        = string
}

resource "aws_instance" "test_instance" {
  ami           = "ami-04f59c565deeb2199"      # replace with your AMI
  instance_type = "t2.micro"
  key_name      = "tusharnvc"

  # Automatically run setup on EC2 launch
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y curl tar jq

              # Create runner directory
              sudo mkdir -p /home/ubuntu/actions-runner
              cd /home/ubuntu/actions-runner

              curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v2.328.0/actions-runner-linux-x64-2.328.0.tar.gz
              tar xzf ./actions-runner.tar.gz
              rm actions-runner.tar.gz

              sudo chown -R ubuntu:ubuntu /home/ubuntu/actions-runner

              sudo -u ubuntu ./config.sh --unattended \
                --url https://github.com/SUBANALYTICS \
                --token "${runner_token}" \
                --name ec2-org-runner \
                --labels self-hosted,linux,ec2 \
                --work "_work"

              # Install and start service
              sudo ./svc.sh install
              sudo ./svc.sh start
              EOF

  tags = {
    Name = "test-instance"
  }
}
