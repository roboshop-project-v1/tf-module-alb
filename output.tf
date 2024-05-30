output "alb" {
  value = aws_lb.test
}

output "listener" {
  value = aws_lb_listener.main
}