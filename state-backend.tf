terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "terraform-test-121"      # your bucket name
    key            = "project-name/env/terraform.tfstate"  # path inside bucket
    region         = "ap-south-1"                     # bucket’s region
    encrypt        = true                             # SSE‑S3 encryption
#    dynamodb_table = "terraform-state-lock"           # for state locking
  }
}
