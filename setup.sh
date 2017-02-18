#!/bin/bash

function ok_or_exit {
	echo "$1"
	if [ $1 == 0 ]; then
		echo "OK"
	else
		echo "Something went wrong"
		exit 1
	fi	
}

function cfg_folder {
	echo "Checking cfg folder: "
	if [ ! -d ./cfg ]; then
		echo -n -e "\tCreating - "
		mkdir -p ./cfg
		ok_or_exit $?
	else
		echo -e "\tFolder already created."
	fi
}

function create_credentials {
	echo "Checking credentials file: "
	if [ -f ./cfg/credentials ];then
		echo -e "\t./cfg/credentials file will be overwritten"
	fi

	echo -n -e "\tCreating - "

	cat << FOO > ./cfg/credentials
[terraform]
aws_access_key_id=$1
aws_secret_access_key=$2
region=sa-east-1
FOO
	ok_or_exit $?
}

function create_tfvars {
	echo "Checking terraform.tfvars file: "
	if [ -f ./cfg/terraform.tfvars ];then
		echo -e "\t./terraform.tfvars file will be overwritten"
	fi

	echo -n -e "\tCreating - "
	cat << FOO > ./terraform.tfvars
aws_access_key = "$1"
aws_secret_key = "$2"
timestamp="$3"
tfstate="$4"
project_name="$5"
FOO
	ok_or_exit $?
}


function remote_actions {
	echo "Executing| Terraform remote config: "
	terraform remote config -backend=S3 \
		-backend-config="bucket=${1}" \
		-backend-config="key=$3" \
		-backend-config="region=$2" \
		-backend-config="shared_credentials_file=./cfg/credentials" \
		-backend-config="profile=terraform"
	echo -n -e "\tRemote configuration - "
	ok_or_exit $?
	
	echo "Executing| Terraform getting modules: "
	terraform  get
	echo -n -e "\Getting modules - "
}

terraform --version > /dev/null 2>&1

if [ $? != 0 ]; then
	echo "terraform command not found. Exiting..."
fi

TIMESTAMP=$(date +"%d-%m-%y")

echo "Configuration for ERN Cluster"
read -p "INPUT| AWS ACCESS KEY: " ACCESS_KEY

read -p "INPUT| AWS SECRET KEY: " SECRET_KEY

read -p "INPUT| S3 bucket name for tfstate file: " BUCKET_NAME

read -p "INPUT | S3 bucket region: " BUCKET_REGION
read -p "INPUT| Cluster Name: " PROJECT_NAME

BASENAME="${PROJECT_NAME}_${TIMESTAMP}"
tfstate_file="$BASENAME.tfstate"

echo "tfstate file name: $tfstate_file"

cfg_folder
create_credentials $ACCESS_KEY $SECRET_KEY

create_tfvars $ACCESS_KEY $SECRET_KEY $TIMESTAMP $tfstate_file $PROJECT_NAME

remote_actions ${BUCKET_NAME} ${BUCKET_REGION} $tfstate_file 
