resource "aws_security_group" "ssh" {
    name = "sg_${var.proj_name}_ssh"
    description = "Allow traffic to ssh/bastion machine"
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "SSH/Bastion"
    }

}

resource "aws_security_group" "nat" {
    name = "sg_${var.proj_name}_nat"
    description = "Allow traffic to pass from the private subnet to the internet"
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "NATSG"
    }
}

resource "aws_security_group_rule" "ingress-to-ssh-acc" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ssh.id}"
}

resource "aws_security_group_rule" "egress-ssh-acc" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.ssh.id}"
}

resource "aws_security_group_rule" "ingress-http-to-nat" {
  type              = "ingress"
  from_port         = 80 
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${aws_subnet.private_subnet.*.cidr_block}"]
  security_group_id = "${aws_security_group.nat.id}"
}

resource "aws_security_group_rule" "ingress-https-to-nat" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["${aws_subnet.private_subnet.*.cidr_block}"]
  security_group_id = "${aws_security_group.nat.id}"
}

resource "aws_security_group_rule" "http-egress-from-nat" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nat.id}"
}

resource "aws_security_group_rule" "https-egress-from-nat" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nat.id}"
}

resource "aws_security_group_rule" "icmp-ingress-in-nat" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nat.id}"
}

resource "aws_security_group_rule" "icmp-egress-from-nat" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nat.id}"
}
