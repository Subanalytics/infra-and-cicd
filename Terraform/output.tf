output "instance_id" {
  description = " EC2 instance ID"
  value       = aws_instance.test_instance.id
}

output "public_ip" {
  description = " EC2 instance public IP"
  value       = aws_instance.test_instance.public_ip
}