resource "random_shuffle" "az" {
    input        = ["${var.subnet_ids}"] 
    result_count = "1" 
    seed         = "seed_for_emr"
}

resource "aws_emr_cluster" "tf-test-cluster" {
    name                 = "emr_cs_test"
    release_label        = "${var.label}"

    master_instance_type = "${var.master_type}"
    service_role         = "${aws_iam_role.iam_emr_service_role.arn}"
    
    core_instance_type   = "${var.core_type}" 
    core_instance_count  = 3 

    log_uri = "s3://${join("", list("ermlogbucket", lower(var.proj_name)))}/logs/"
   
 
    applications           = "${split(",", var.apps)}"
    termination_protection = "false"

    ec2_attributes{
        key_name = "${var.pem_name}"
        subnet_id = "${element(random_shuffle.az.result,1)}"
        instance_profile = "${aws_iam_instance_profile.emr_profile.arn}"
    }
    
    bootstrap_action {
        path = "s3://elasticmapreduce/bootstrap-actions/run-if"
        name = "runif"
        args = ["instance.isMaster=true", "echo running on master node"]
    }

    tags {
        Name     = "EMR Cluster Machine"
  }
}
