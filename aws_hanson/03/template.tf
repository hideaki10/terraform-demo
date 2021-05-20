resource "aws_launch_template" "blog" {
  name            = "launch-01"
  default_version = 1
  image_id        = aws_ami_from_instance.blog.id
  instance_type   = var.cpu_options
  key_name        = var.key_pair

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "WebServer-Auto"
    }
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      aws_security_group.blog_sg.id
    ]
  }
}