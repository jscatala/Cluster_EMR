variable "ts" {}
variable "region" {}
variable "av_zones" {}
variable "pem" {}
variable "pem_path" {} 
variable "cidr_block" {}
variable "proj_name" {}

variable "cidr_block_sub" {
   default = {
      "0"  = "10.0.0.0/24"
      "1"  = "10.0.1.0/24"
      "2"  = "10.0.2.0/24"
      "100"  = "10.0.100.0/24"
      "101"  = "10.0.101.0/24"
      "102"  = "10.0.102.0/24"
   }
}

variable "NAT_AMI" {
	default = "ami-67a54423"
}

variable "amzn_AMI" {
  default = "ami-31490d51"
}
