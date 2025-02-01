variable "aws-region" {
  default = "us-east-1"
}

variable "username" {
  default = "ubuntu"

}

variable "instance_count" {
  default = "3"
}
variable "PRIV_KEY_PATH" {
  default = "/home/ubuntu/MyServer1"
}

variable "PUB_KEY_PATH" {
  default = "/home/ubuntu/MyServer1.pub"
}


variable "VPC_NAME" {
  default = "New-Vpc"
}

variable "Zone1" {
  default = "us-east-1a"
}

variable "VpcCIDR" {
  default = "172.21.0.0/16"
}

variable "PubSub1CIDR" {
  default = "172.21.1.0/24"
}

variable "AMIS" {

  default = "ami-0e2c8caa4b6378d8c"


}
variable "PrivSub1CIDR" {
  default = "172.21.4.0/24"
}
variable "MY_IP" {
  type    = string
  default = "45.118.156.57/32"

}
