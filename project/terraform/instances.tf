resource "aws_instance" "dev_server" {
  ami           = "ami-0d527b8c289b4af7f"
  instance_type = "t2.micro"
  key_name      = "ec2-tf"
  vpc_security_group_ids = [aws_security_group.udorosh-sg.id]
  tags = {
    Name    = "My Dev Server"
    Owner   = "Yurii Dorosh"
    Project = "PetClinic from udorosh"
  }
}
resource "aws_instance" "prod_server" {
  ami           = "ami-0d527b8c289b4af7f"
  instance_type = "t2.micro"
  key_name      = "ec2-tf"
  vpc_security_group_ids = [aws_security_group.udorosh-sg.id]
  tags = {
    Name    = "My Prod Server"
    Owner   = "Yurii Dorosh"
    Project = "PetClinic from udorosh"
  }
}
