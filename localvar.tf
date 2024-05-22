locals {
  sg_name = var.internal? "${var.env}-alb-internal-sg":"${var.env}-alb-public-sg"
  lb_name = var.internal? "${var.env}-alb-internal":"${var.env}-alb-public"
}