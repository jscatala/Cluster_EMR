output "vpc_id" {
   value = "${aws_vpc.vpc.id}"
}

output "private_ids" {
   value = ["${aws_subnet.private_subnet.*.id}"]
}

output "public_ids" {
   value = ["${aws_subnet.public_subnet.*.id}"]
}

output "ssh_sg" {
  value = "${aws_security_group.ssh.id}"
}

output "nat_sg" {
  value = "${aws_security_group.nat.id}"
}
