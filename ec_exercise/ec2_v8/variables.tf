variable "aws_region" {

}
variable "aws_profile" {

}

variable "aws_subnet_id" {

}

variable "instance_type" {

}

variable "cidr_block" {

}
variable "subnet_cidr_block" {

}

variable "amis" {
  type = map(string)
  default = {
    ap-northeast-1 = "ami-034968955444c1fd9"
  }
}
