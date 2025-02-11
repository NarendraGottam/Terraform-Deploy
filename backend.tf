terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-gopi"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

