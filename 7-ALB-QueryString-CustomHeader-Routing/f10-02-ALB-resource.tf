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
      #target_group_index = 0
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  target_groups = [
    # Target group index 0
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
          target_id = [for n in module.Private_EC2_1: n.id][0]
          port      = 80
        },
        app1_vm2 = {
          target_id = [for n in module.Private_EC2_1: n.id][1]
          port      = 80
        }
      }
      tags = local.common_tags
    },
    # Target group index 1
    {
      name_prefix                       = "app2-"
      backend_protocol                  = "HTTP"
      backend_port                      = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      targets = {
        app2_vm1 = {
          target_id = [for n in module.Private_EC2_2: n.id][0]
          port      = 80
        },
        app2_vm2 = {
          target_id = [for n in module.Private_EC2_2: n.id][1]
          port      = 80
        }
      }
      tags = local.common_tags
    }
  ]

  # HTTPS listener
  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm.acm_certificate_arn
      #target_group_index = 1
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed message - Akshay S A application Home Page"
        status_code  = "200"
      }
    }
  ]

  # Listener rules
  https_listener_rules = [
    #Rule-1 = Custom-header routes to Application-1
    {
      https_listener_index = 0
      priority = 1
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        #path_patterns = ["/app1*"]
        #host_headers = [var.app1_dns_name]
        http_headers = [{
          http_header_name = "custom-header"
          values           = ["app1", "myapp1"]
        }]
      }]
    },
    #Rule-2 = Custom-header routes to Application-2
    {
      https_listener_index = 0
      priority = 2
      actions = [
        {
          type               = "forward"
          target_group_index = 1
        }
      ]
      conditions = [{
        #path_patterns = ["/app2*"]
        #host_headers = [var.app2_dns_name]
        http_headers = [{
          http_header_name = "custom-header"
          values           = ["app2", "myapp2"]
        }]
      }]
    },
    #Rule-3 = Query string routing
    {
      https_listener_index = 0
      priority             = 3
      actions = [{
        type        = "redirect"
        status_code = "HTTP_302"
        host        = "www.youtube.com"
        path        = "/@akshaysa"
        query       = ""
        protocol    = "HTTPS"
      }]

      conditions = [{
        query_strings = [{
          key   = "website"
          value = "youtube"
        }]
      }]
    },
    #Rule-4 = Host-Header routing
    {
      https_listener_index = 0
      priority             = 4
      actions = [{
        type        = "redirect"
        status_code = "HTTP_302"
        host        = "www.linkedin.com"
        path        = "/in/akshayashok1991/"
        query       = ""
        protocol    = "HTTPS"
      }]

      conditions = [{
        host_headers = ["linkedin.akshaydevops.click"]
      }]
    }
  ]

}