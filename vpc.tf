resource "aws_vpc" "name" {
  tags_all = var.default_tags
  tags = {
    Name = "${var.default_tags.key1}-vpc"
  }
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "pbsubnet" {
  vpc_id     = aws_vpc.name.id
  count = var.subnetcount
  
cidr_block = cidrsubnet("10.0.0.0/20", 4, count.index)

  
  availability_zone = var.az[count.index < 3 ? count.index : count.index % 3]
   tags = {
    Name = "${count.index} - ${var.az[count.index < 3 ? count.index : count.index % 3]}"
    }
}

resource "aws_instance" "test" {
  ami = "ami-074cce78125f09d61"
  instance_type           = "t3.micro"
  subnet_id = aws_subnet.pbsubnet[0].id
}
