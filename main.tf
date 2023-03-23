provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  default_tags {
    tags = {
      k1 =var.default_tags.key1
      k2 = var.default_tags["key2"]
    }
  }

  
  s3_use_path_style           = false
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

}