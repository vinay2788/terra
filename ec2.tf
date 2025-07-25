resource "aws_instance" "terrakube" {
  ami                         = "ami-0f918f7e67a3323f0"
  associate_public_ip_address = true
  instance_type               = "t2.large"
  key_name                    = "vinay-legitbytes"

  tags = {
    Name = "terrakube"
  }
}
