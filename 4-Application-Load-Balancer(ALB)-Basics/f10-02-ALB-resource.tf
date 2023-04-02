module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "4.0.1"

  name = "${local.name}-CLB"

  subnets         = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  security_groups = [module.loadbalancer_SG.security_group_id]
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "81"
      lb_protocol       = "HTTP"
    }  
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  tags = {
    Owner       = "${local.name}-CLB"
    Environment = "${local.environment}"
  }

  # ELB attachments
  number_of_instances = 2
  instances           = [for n in module.Private_EC2: n.id]

}