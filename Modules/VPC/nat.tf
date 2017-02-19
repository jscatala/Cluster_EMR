/*
  NAT Instance
*/

resource "random_shuffle" "az" {
    input        = ["${aws_subnet.public_subnet.*.id}"] 
    result_count = "1"
}

resource "aws_instance" "nat" {
    ami = "${lookup(var.NAT_AMI, var.region)}"
    instance_type = "m1.small" # This is static, and may vary on regions
    key_name = "${var.pem}"
    security_groups = ["${aws_security_group.nat.id}"]
    associate_public_ip_address = true
    source_dest_check = false
    vpc_security_group_ids= ["${aws_security_group.nat.id}"]
    subnet_id = "${element(random_shuffle.az.result,2)}" #TODO: randomize the process 

    tags {
        Name = "VPC NAT"
    }
}

resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc = true
}
