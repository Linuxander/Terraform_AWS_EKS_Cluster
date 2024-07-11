terraform {
  backend "s3" {
    profile = "[your profile name here]"
    bucket  = "[your bucket name goes here]"
    key     = "[AWS S3 path to your terraform.tfstate file]"
    region  = "us-east-1"
  }
}
