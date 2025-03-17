terraform {
    backend "s3" {
        bucket = "terraformstate98765"
        key = "terraform/backend"
        region = "us-east-1"
    }
}