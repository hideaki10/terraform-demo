data "template_file" "name" {
  template = file("${path.module}/install_nginx.yaml")

  vars = {
    package_name = "redis"
  }
}

output "output_name" {
  value = data.template_file.name.rendered
}
