module "EMR" {
    source     = "Modules/EMC"
    proj_name  = "${var.project_name}"
    vpc_id     = "${module.Network.vpc_id}"
    region     = "${var.aws_region}"
    subnet_ids = "${module.Network.private_ids}"
    pem_name   = "${var.aws_pem}"
    label      = "${var.r_label}"
    core_count = "${var.emr_core_count}"
    apps       = "${var.applications}"
}
