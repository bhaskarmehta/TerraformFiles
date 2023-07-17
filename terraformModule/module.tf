resource "aws_instance" "s1"{
 ami = "ami-0261755bbcb8c4a84"
 instance_type = "t2.micro"

 tags = {
 Name = "Module-Server"
}
}
