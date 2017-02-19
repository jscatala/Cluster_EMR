variable "ts" {}
variable "region" {}
variable "av_zones" {}
variable "pem" {}
variable "pem_path" {} 
variable "cidr_block" {}
variable "proj_name" {}

variable "NAT_AMI" {
	default = {
		"us-weast-1" = "ami-67a54423"
		"sa-east-1"  = "ami-93fb408e"
	}
}

variable "amzn_AMI" {
  default = {
	"us-weast-1" = "ami-31490d51"
        "sa-east-1"  = "ami-80086dec"
 }
}
