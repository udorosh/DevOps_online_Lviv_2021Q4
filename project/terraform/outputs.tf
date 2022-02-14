output "lastetst_ubuntu_ami_id" {
  value = data.aws_ami.lastest_ubuntu.id
}
output "lastetst_ubuntu_ami_name" {
  value = data.aws_ami.lastest_ubuntu.name
}


output "dev_server_ip" {
  value = aws_instance.dev_server.public_ip
}
output "dev_server_dns" {
  value = aws_instance.dev_server.public_dns
}


output "prod_server_ip" {
  value = aws_instance.prod_server.public_ip
}
output "prod_server_dns" {
  value = aws_instance.prod_server.public_dns
}
