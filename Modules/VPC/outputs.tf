output "vpc_id" {
   value = "${aws_vpc.vpc.id}"
}

output "private_1b_id" {
   value = "${aws_subnet.private_1b.id}"
}

output "private_1c_id" {
   value = "${aws_subnet.private_1c.id}"
}

output "public_1b_id" {
   value = "${aws_subnet.public_1b.id}"
}

output "public_1c_id" {
   value = "${aws_subnet.public_1c.id}"
}

output "ssh_public_ip" {
	value = "${aws_instance.ssh.public_ip}"
}

output "ssh_sg" {
  value = "${aws_security_group.ssh.id}"
}

output "nat_sg" {
  value = "${aws_security_group.nat.id}"
}