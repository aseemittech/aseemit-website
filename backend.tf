#######################################################################
# Defines the terraform state backend
########################################################################

terraform {
  backend "s3" {
    region         = "us-east-1"
    key            = "533267434422/dev.tfstate"
    bucket         = "aseemit-site-tf-state"
    dynamodb_table = "aseemit-site-tf-state"
    acl            = "bucket-owner-full-control"
    encrypt        = true
  }
}
