resource "aws_instance" "webserver" {
	ami	= "ami-xxxxx"
	instance_type ="t2.micro"
}
resource "aws_s3_bucket" "finance" {
	bucket	= "ami-xxxxx"
	instance_type ="t2.micro"
}
