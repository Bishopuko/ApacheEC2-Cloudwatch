resource "aws_instance" "Apache-aws_instance" {
    ami = "ami-08778753ef37aa408"
    instance_type = "t2.micro"
    key_name = "dev-kp"
    user_data = "${file("./Apache-Script/Apache.sh")}"
    
    
    tags = {
      "Name" : "Apache-Instance"
    }
}
