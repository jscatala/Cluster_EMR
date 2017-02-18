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

##Creation of S3 Bucket

Because we want to use the remote tfstate configuration, we want a safe place to store it. Due that, we have to create a S3 bucket on AWS. It is recommended to enable the versioning capabilities of S3, so all changes into our current infrestructure are safely saved.

## EC2 Pem file

A Pem file generated/available with capabilities to reach ec2 machines will be needed. This file could be located into the cfg folder. This folder it is not tracked by git nor are the files with *.pem* extension.

---

#Project Configuration 

Before plan to build our infrestructure, we need to setup the project thru the **setup.sh** script. This script will create the *cfg folder*, where the credentials and the base tfvars file.

The script will ask:

* AWS access key
* AWS secret key
* S3 bucket name
* S3 bucket region
* Give a project name for the current infrestructure ran

---

#File Stucture

The structure given to the project is sorted by modules. This gives the possibillity to easly add or remove modules as needed. 

##Root Folder

###Module related Files
* vpc.tf: In charge to handle the creation of all resources related to the creation of a VPC

###Variables

* terraform.tfvars: Variables that are part needed for the project but may vary from users/projects
* initialize.tf: Variables that may be initialized thru terraform.tfvars or provided by the user at runtime
* variables.tf: Variables which has already default options, but if the user needs, can be provided too

##Modules Folder

###VPC
* bastion.tf: Configuration for an ec2 bastion/ssh machine responsable of reach internal machines from *outside world*
* nat.tf: Configuration for a nat instance and its corresponding elastic ip
* outputs.tf
* sg.tf: Configuration for basic security groups
* subnets.tf: Configuration for private and public subnets into the VPC
* variables.tf
* vpc.tf: Main file of the module. Responsible to create the VPC and the gateway

