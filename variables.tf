variable "aws_region" {
   default =  "sa-east-1"
}

variable "av_zones" {
    default = {
        "us-west-1" = "us-west-1b,us-west-1c"
        "us-west-2" = "us-west-2a,us-west-2b,us-west-2c"
        "us-east-1" = "us-east-1c,us-west-1d,us-west-1e"
	"sa-east-1" = "sa-east-1a,sa-east-1b,sa-east-1c"
    }
}

variable "cidr_block" {
    default = "10.0.0.0/16"
}
