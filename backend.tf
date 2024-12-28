terraform {
  backend "s3" {
    bucket  = "aryabucketoinfy"
    key     = "statefile/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
