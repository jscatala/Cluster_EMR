/*
PRIVATE SUBNETS 

Routing table needs to be associated to a nat instance with eip

*/
resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags {
        Name = "Private Subnet ${var.proj_name}"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id            = "${aws_vpc.vpc.id}"
    count             = "${length(split(",", var.av_zones))}"
    cidr_block        = "${cidrsubnet(var.cidr_block,length(split(",", var.av_zones))*2 , count.index)}"
    availability_zone = "${element(split(",", var.av_zones), count.index)}"
    map_public_ip_on_launch = "false"
    tags {
        "Name" = "private-${element(split(",", var.av_zones), count.index)}-sn"
    }

}

resource "aws_route_table_association" "private" {
    count          = "${length(split(",", var.av_zones))}"
    subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
    route_table_id = "${aws_route_table.private.id}"
}



/*
PUBLIC SUBNETS 

Routing table needs to be associated to a igw 

*/
resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "Public Subnet ${var.proj_name}"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id            = "${aws_vpc.vpc.id}"
    count             = "${length(split(",", var.av_zones))}"
    cidr_block        = "${cidrsubnet(var.cidr_block, length(split(",", var.av_zones))*2, count.index+13)}"
    availability_zone = "${element(split(",", var.av_zones), count.index)}"
    map_public_ip_on_launch = "false"
    tags {
        "Name" = "public-${element(split(",", var.av_zones), count.index)}-sn"
    }

}

resource "aws_route_table_association" "public" {
    count          = "${length(split(",", var.av_zones))}"
    subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
    route_table_id = "${aws_route_table.public.id}"
}

