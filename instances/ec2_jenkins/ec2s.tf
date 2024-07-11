resource "aws_instance" "ec2_jenkins" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.medium"

  key_name   = "aws_key_pair_ec2_jenkins"
  monitoring = true

  subnet_id              = var.netmod_jenkins_sub_id
  vpc_security_group_ids = [var.netmod_jenkins_sg_id]

  associate_public_ip_address = true

  user_data = file("${path.module}/scripts/ec2-jenkins-user-data.sh")

  tags = {
    Name = "${var.project_name} - ec2 - jenkins"
  }
}