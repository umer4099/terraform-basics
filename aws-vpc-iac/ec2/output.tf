# output "all" {
#     value = data.terraform_remote_state.vpc
  
# }
# output "ubuntu_sg" {
#     description = "secuirty group for ec2 "
#     value = aws_security_group.web_server_sg_tf
  
# }
output "ssh_command" {
    value = "ssh ubuntu@${aws_instance.example_server.public_ip}"
  
}