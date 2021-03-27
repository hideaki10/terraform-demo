locals {
  should_create_vpc = true

  num_of_subnets = local.should_create_vpc == true ? 2 : 0
}

output "num_of_students" {
  value       = local.num_of_subnets
  description = "value"
}
