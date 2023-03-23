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
  az=5
  pb=8
  c=( (pb>az) ? pb % az : az)

  tags = {
    Name = "${var.default_tags["key2"]}-vpc-count.index"
    test = c
  }
  vpc_id     = aws_vpc.name.id
  count =(var.pbsubnetcount.index > var.azcount.index ? (var.pbsubnetcount.index % var.azcount.index) : var.azcount.index )
  cidr_block = cidrsubnet("10.0.0.0/16", 4, count.index)
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.name.id

  tags = {
    Name = "main"
    Project ="${var.default_tags.key1}"
  }
}
