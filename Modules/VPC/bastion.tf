resource "aws_instance" "ssh" {
    ami                         = "${var.amzn_AMI}"
    availability_zone           =  "${element(split(",", var.av_zones), 1)}"
    instance_type               = "t2.micro"  # instance type has to be specified 
    key_name                    = "${var.pem}"
    vpc_security_group_ids      = ["${aws_security_group.ssh.id}"] 
    subnet_id                   = "${aws_subnet.public_1b.id}"
    associate_public_ip_address = true

    tags {
        Name = "SSH/Bastion"
        TimeStamp = "${var.ts}"
    }

    connection {
      user = "ec2-user"
      type = "ssh"
      key_file = "${var.pem_path}/${var.pem}.pem"
      timeout = "2m"
    }

    # Update System 
    provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo yum update -y",
    ]
  }

}
