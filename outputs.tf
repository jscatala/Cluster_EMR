output "VPC_id" {
   value = "${module.Network.vpc_id}"
}

#output "SSH/Bastion" {
#   value = "${module.Network.ssh_public_ip}"
#}

output "Priv_net_ids" {
   value = "${module.Network.private_ids}"
}

output "Pub_net_ids" {
   value = "${module.Network.public_ids}"
}

output "SSH_SG" {
  value = "${module.Network.ssh_sg}"
}

output "NAT_SG" {
  value = "${module.Network.nat_sg}"
}
