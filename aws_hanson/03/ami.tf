// EC2からamiを作成
resource "aws_ami_from_instance" "blog" {
  name               = "web_server"
  source_instance_id = aws_instance.ec2-blog[0].id
}