# Cluster_EMR
Terraform Configuration that handles the creation of an ElasticMap Reduce cluster

The set up has to be able to handle:
1. Create and properly handle the VPC where the cluster will be allocated 
2. All network, creation and configurations
3. Security Groups
4. Handle all S3 operations in order to have proper input and output to the EMR cluster
5. Profiles and Roles for IAM
6. The EMR Cluster itself

---

#Manual Steps

Because we want to use the remote tfstate configuration, we want a safe place to store it. Due that, we have to create a S3 bucket on AWS. Its is recommended to enable the versioning capabilities of S3, so all changes into our current infrestructure are saved.



#Project Configuration 

Before plan to build our infrestructure, we need to setup the project thru the **setup.sh** script. This script will create the *cfg folder*, where the credentials and the base tfvars file.

The script will ask:

* AWS access key
* AWS secret key
* S3 bucket name
* S3 bucket region
* Give a project name for the current infrestructure ran


