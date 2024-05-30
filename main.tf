
resource "aws_lb" "test" {
  name               = local.lb_name
  internal           = var.internal
  load_balancer_type = var.alb_type
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnet_ids
  tags = var.tags
}


resource "aws_security_group" "lb_sg" {
  name        = local.sg_name
  description = local.sg_name
  vpc_id      = var.vpc_id
  tags = var.tags
}



resource "aws_security_group_rule" "lb_sg" {
  type              = "ingress"
  from_port         = var.sg_port
  to_port           = var.sg_port
  protocol          = "tcp"
  cidr_blocks       = var.sg_ingress_cidr
  security_group_id = aws_security_group.lb_sg.id
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

