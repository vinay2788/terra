resource "aws_instance" "terrakube" {
    ami                                  = "ami-0f918f7e67a3323f0"
    arn                                  = "arn:aws:ec2:ap-south-1:163622408307:instance/i-0a9b135e899bc235a"
    associate_public_ip_address          = true
    availability_zone                    = "ap-south-1a"
    disable_api_stop                     = false
    disable_api_termination              = false
    instance_type                        = "t2.large"
    ipv6_address_count                   = 0
    ipv6_addresses                       = []
    key_name                             = "vinay-legitbytes"
  
}