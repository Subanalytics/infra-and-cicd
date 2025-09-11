resource "aws_instance" "test_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y curl tar jq

# Create runner directory
mkdir -p /home/ubuntu/actions-runner
cd /home/ubuntu/actions-runner

# Download and extract GitHub Actions runner
curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v2.328.0/actions-runner-linux-x64-2.328.0.tar.gz
tar xzf ./actions-runner.tar.gz
rm actions-runner.tar.gz

sudo chown -R ubuntu:ubuntu /home/ubuntu/actions-runner

# Configure the runner
sudo -u ubuntu ./config.sh --unattended \
  --url https://github.com/SUBANALYTICS \
  --token "${var.runner_token}" \
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

