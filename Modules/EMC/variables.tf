variable "proj_name" {}
variable "vpc_id" {}
variable "region" {}
variable "subnet_ids" {
    type = "list"
}

variable "pem_name" {}
variable "label" {}

variable "master_type" {
    default = "m3.xlarge"
}

variable "core_type" {
    default = "m3.xlarge"
}

variable "core_count" {
    default = 4
}

variable "apps" {
    default = "Hive"
}
