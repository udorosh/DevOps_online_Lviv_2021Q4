resource "aws_instance" "dev_server" {
  ami           = "ami-0d527b8c289b4af7f"
  instance_type = "t2.micro"
  key_name      = "ec2-tf"
  vpc_security_group_ids = [aws_security_group.kiykomi-sg.id]
  tags = {
    Name    = "My Dev Server"
    Owner   = "Mikhail Kiyko"
    Project = "PetClinic from kiykomi"
  }
}
resource "aws_instance" "prod_server" {
  ami           = "ami-0d527b8c289b4af7f"
  instance_type = "t2.micro"
  key_name      = "ec2-tf"
  vpc_security_group_ids = [aws_security_group.kiykomi-sg.id]
  tags = {
    Name    = "My Prod Server"
    Owner   = "Mikhail Kiyko"
    Project = "PetClinic from kiykomi"
  }
}
