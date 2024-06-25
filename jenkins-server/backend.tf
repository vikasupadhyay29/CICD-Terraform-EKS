terraform {
  backend "s3" {
    bucket = "mytodoappbucketlist"
    key    = "jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}