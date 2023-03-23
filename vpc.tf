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
  scount = (count.index <=3 ? count.index : count.index % 3  )
  cidr_block = cidrsubnet("10.0.0.0/16",4,var.scount)
   tags = {
    Name = "${var.default_tags["key2"]}- count.index"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.name.id

  tags = {
    Name = "main"
    Project ="${var.default_tags.key1}"
  }
}
