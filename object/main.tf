variable "object" {
  type = object(
    {
      vpc_name       = string
      num_of_subnets = number
      create_igw     = bool
    }
  )

  default = {
    vpc_name       = "test"
    num_of_subnets = 3
    create_igw     = true
  }

}


variable "map" {
  type = map(string)

  default = {
    vpc_name           = "test"
    pubilc_subnet_name = "public subnet"
    create_igw         = true
  }
}

output "object" {
  value = var.object.vpc_name
}

output "map" {
  value = var.map.vpc_name

}
