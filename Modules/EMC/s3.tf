resource "aws_s3_bucket" "b" {
    bucket = "${join("", list("ermlogbucket", lower(var.proj_name)))}"
    acl = "private"
    region = "${var.region}"

    tags {
        Name        = "ern log bucket"
        Project     = "${var.proj_name}"
    }
}
