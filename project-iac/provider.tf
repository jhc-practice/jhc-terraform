provider "aws" {
  region = "us-east-2"
  default_tags{
    tags={
      AppName="hrautomation"
      CostCenter="jhc777"
   }
  }
}