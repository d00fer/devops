provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "expample" {
  ami           = "ami-0f29c8402f8cce65c"
  instance_type = "t2.micro"
  tags = {
    Name = "example"
  }
}
