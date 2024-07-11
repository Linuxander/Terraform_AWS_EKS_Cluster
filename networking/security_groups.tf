resource "aws_security_group" "my_webapi_securitygroup" {
  name        = "my_webapi_securitygroup"
  description = "Security group for allowing HTTP, HTTPS, and SSH"
  vpc_id      = aws_vpc.my_vpc.id

  dynamic "ingress" {
    for_each = local.allowed_ips_for_http
    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allowed IP addresses"
    }
  }

  dynamic "ingress" {
    for_each = local.allowed_ips_for_http
    content {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allowed IP addresses"
    }
  }

  dynamic "ingress" {
    for_each = local.allowed_ips_for_ssh
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allowed IP addresses"
    }
  }

  dynamic "egress" {
    for_each = local.allowed_ips_for_http
    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [egress.value]
      description = "Allowed IP addresses"
    }
  }

  dynamic "egress" {
    for_each = local.allowed_ips_for_http
    content {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [egress.value]
      description = "Allowed IP addresses"
    }
  }

  # Allows all outbound traffic
  #egress {
  #  from_port   = 0
  #  to_port     = 0
  #  protocol    = "-1"  # -1 means all protocols
  #  cidr_blocks = ["0.0.0.0/0"]
  #}

  tags = {
    Name = "${var.project_name} - security group - webapi"
  }
}

resource "aws_security_group" "my_jenkins_securitygroup" {
  name        = "my_jenkins_securitygroup"
  description = "Security group for allowing HTTP, HTTPS, and SSH"
  vpc_id      = aws_vpc.my_vpc.id

  dynamic "ingress" {
    for_each = local.allowed_ips_for_jenkins_server
    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allowed IP addresses"
    }
  }

  dynamic "ingress" {
    for_each = local.bitbucket_ips
    content {
      from_port   = 8080 // or 443 if you're using HTTPS
      to_port     = 8080 // or 443 if you're using HTTPS
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allow Bitbucket webhook"
    }
  }

  dynamic "ingress" {
    for_each = local.allowed_ips_for_jenkins_server
    content {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allowed IP addresses"
    }
  }

  dynamic "ingress" {
    for_each = local.allowed_ips_for_ssh
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allowed IP addresses"
    }
  }

  dynamic "ingress" {
    for_each = local.allowed_ips_for_jenkins_server
    content {
      from_port   = 8080 // or 443 if you're using HTTPS
      to_port     = 8080 // or 443 if you're using HTTPS
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allow IPs to connect to jenkins"
    }
  }

  # Allows all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name} - security group - jenkins"
  }
}