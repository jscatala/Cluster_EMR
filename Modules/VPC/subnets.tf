/*
PRIVATE SUBNETS (10.0.10x.0/24)

Routing table needs to be associated to a nat instance with eip

*/

resource "aws_subnet" "private_1b" {
   availability_zone       = "${element(split(",", var.av_zones), 1)}"
   cidr_block              = "${lookup(var.cidr_block_sub, 101)}"
   map_public_ip_on_launch = "false"
   vpc_id                  = "${aws_vpc.vpc.id}"
   tags = {
      Name = "OsaControl-${var.proj_name}-PrivateSubnet-1b"
   }
}

resource "aws_subnet" "private_1c" {
   availability_zone       = "${element(split(",", var.av_zones), 2)}"
   cidr_block              = "${lookup(var.cidr_block_sub, 102)}"
   map_public_ip_on_launch = "false"
   vpc_id                  = "${aws_vpc.vpc.id}"
   tags = {
      Name = "OsaControl-${var.proj_name}-PrivateSubnet-1c"
   }
}

resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags {
        Name = "Private Subnet ${proj_name}"
    }
}

resource "aws_route_table_association" "private_1b" {
    subnet_id = "${aws_subnet.private_1b.id}"
    route_table_id = "${aws_route_table.private.id}"
}



resource "aws_route_table_association" "private1_c" {
    subnet_id = "${aws_subnet.private_1c.id}"
    route_table_id = "${aws_route_table.private.id}"
}

/*

PUBLIC SUBNET (10.0.x.0/24)

Routing table is associated to igw

*/


resource "aws_subnet" "public_1b" {
  availability_zone       = "${element(split(",", var.av_zones), 1)}"
  cidr_block              = "${lookup(var.cidr_block_sub, 0)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  tags = {
    Name = "OsaControl-${var.proj_name}-PublicSubnet-1b"
  }
}

resource "aws_subnet" "public_1c" {
  availability_zone       = "${element(split(",", var.av_zones), 2)}"
  cidr_block              = "${lookup(var.cidr_block_sub, 1)}"
  map_public_ip_on_launch = "false"
  vpc_id                  = "${aws_vpc.vpc.id}"
  tags = {
    Name = "OsaControl-${var.proj_name}-PublicSubnet-1c"
  }
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "Public Subnet ${proj_name}"
    }
}

resource "aws_route_table_association" "public_1b" {
    subnet_id = "${aws_subnet.public_1b.id}"
    route_table_id = "${aws_route_table.public.id}"
}



resource "aws_route_table_association" "public_1c" {
    subnet_id = "${aws_subnet.public_1c.id}"
    route_table_id = "${aws_route_table.public.id}"
}
