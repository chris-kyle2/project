output "jenkins_ip" {
  value = aws_instance.app_instance[0].public_ip
}
output "master_ip" {
  value = aws_instance.app_instance[1].public_ip
}
output "slave_ip" {
  value = aws_instance.app_instance[2].public_ip
}
