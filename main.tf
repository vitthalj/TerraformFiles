module "terraform-aws-dynamodb" {
  source  = "mineiros-io/dynamodb/aws"
  version = "~> 0.6.0"

  name           = "GameScores"
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attributes = {
    UserId    = "S"
    GameTitle = "S"
    TopScore  = "N"
  }

  ttl_attribute_name = "TimeToExist"

  global_secondary_indexes = [
    {
      name               = "GameTitleIndex"
      hash_key           = "GameTitle"
      range_key          = "TopScore"
      write_capacity     = 1
      read_capacity      = 1
      projection_type    = "INCLUDE"
      non_key_attributes = ["UserId"]
    }
  ]

  table_tags = {
    Name        = "terraform-aws-dynamodb"
    Environment = "example"
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# EXAMPLE PROVIDER CONFIGURATION
# ----------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region = "ap-south-1"
}