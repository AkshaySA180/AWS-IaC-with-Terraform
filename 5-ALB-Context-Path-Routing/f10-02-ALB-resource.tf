module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.6.0"

  name = "${local.name}-ALB" 

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  security_groups    = [module.loadbalancer_SG.security_group_id]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name_prefix                       = "app1-"
      backend_protocol                  = "HTTP"
      backend_port                      = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      targets = {
        app1_vm1 = {
          target_id = [for n in module.Private_EC2: n.id][0]
          port      = 80
        },
        app1_vm2 = {
          target_id = [for n in module.Private_EC2: n.id][1]
          port      = 80
        }
      }
      tags = local.common_tags
    }
  ]
}