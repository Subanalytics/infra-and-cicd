#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y curl tar jq

# Create runner dir
sudo mkdir -p /home/ubuntu/actions-runner && cd /home/ubuntu/actions-runner
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



# Install service
sudo ./svc.sh install
sudo ./svc.sh start