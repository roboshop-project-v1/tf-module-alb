
resource "aws_lb" "test" {
  name               = local.lb_name
  internal           = var.internal
  load_balancer_type = var.alb_type
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnet_ids


  tags = env.tags
}


resource "aws_security_group" "lb_sg" {
  name        = local.sg_name
  description = local.sg_name
  vpc_id      = var.vpc_id
  tags = env.tags
}


resource "aws_vpc_security_group_ingress_rule" "lb_sg" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = var.sg_ingress_cidr
  from_port         = var.sg_port
  ip_protocol       = "tcp"
  to_port           = var.sg_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

