/*
  NAT Instance
*/

resource "aws_instance" "nat" {
    ami = "${var.NAT_AMI}"
    instance_type = "t1.micro"
    key_name = "${var.pem}"
    security_groups = ["${aws_security_group.nat.id}"]
    associate_public_ip_address = true
    source_dest_check = false
    vpc_security_group_ids= ["${aws_security_group.nat.id}"]
    subnet_id = "${aws_subnet.public_1b.id}"

    tags {
        Name = "VPC NAT"
    }
}

resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc = true
}