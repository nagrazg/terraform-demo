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

resource "aws_lb_listener" "lbl" {
  load_balancer_arn = aws_lb.lb.arn
  port = 80
  protocol = "http"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.demo.arn
    }
  }

resource "aws_lb_target_group" "demo" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.name.id
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.demo.arn
  target_id        = aws_instance.test.id
  port             = 80
}

resource "aws_instance" "test" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3.micro"
  subnet_id = aws.pbsubnet[0].id
}
