# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Vairable for project name to label tags properly"
  type        = string
}

variable "subnet_cidr_jenkins" {
  description = "This is the CIDR used for Jenkins"
  default     = "10.1.6.0/24"
}