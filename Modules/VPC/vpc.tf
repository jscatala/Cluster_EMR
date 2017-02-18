resource "aws_vpc" "vpc" {
    cidr_block           = "${var.cidr_block}"
    instance_tenancy     = "default"
    enable_dns_support   = "true" 
    enable_dns_hostnames = "true"
    

    tags {
        Name        = "${var.proj_name}-VPC"
        Environment = "${var.proj_name}"
        TimeStramp  = "${var.ts}"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.vpc.id}"
}
