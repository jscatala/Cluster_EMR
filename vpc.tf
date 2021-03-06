module "Network" {
   source     = "Modules/VPC"
   ts         = "${var.timestamp}"
   region     = "${var.aws_region}"
   av_zones   = "${lookup(var.av_zones, var.aws_region)}"
   cidr_block = "${var.cidr_block}"
   pem        = "${var.aws_pem}"
   pem_path   = "${var.pem_folder_path}"
   proj_name  = "${var.project_name}"
}
