variable "aws_profile" {

}

variable "aws_region" {
}

variable "aws_ami" {

}

variable "rds_password" {

}


variable "availability_zone_names" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "cpu_options" {

}

variable "key_pair" {

}