resource "aws_instance" "ec2_instance"{
count =2
ami = data.aws_ami.instance_example.id
instance_type = local.instance_type
//key_name = "proj_demo.pem"
//keypair= local.private_key
tags = {
  //Name = "subnet-${count.index < 2 ? "public-subnet": "private-subnet"}-${count.index+1}"
  Name = "ec2-instance-${count.index < 1 ? "public": "private"}-${count.index+1}"
}

}

//fetch data from existinh ami
data "aws_ami" "instance_example"{

owners = ["amazon"]
most_recent = true

filter {
  name = "name"
  values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
}

}



output "ip_data" {
  value= [for ip in aws_instance.ec2_instance: ip.public_ip]
}