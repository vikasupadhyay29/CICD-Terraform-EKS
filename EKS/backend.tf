terraform {
  backend "s3" {
    bucket = "mytodoappbucketlist"
    key    = "eks/terraform.tfstate"
    region = "ap-south-1"
  }
}