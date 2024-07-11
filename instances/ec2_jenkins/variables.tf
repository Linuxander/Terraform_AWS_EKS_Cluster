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

variable "netmod_my_vpc_id" {
  description = "Network module my_vpc_id reference"
  default     = ""
}

variable "netmod_jenkins_sg_id" {
  description = "Network module jenkins_sg_id reference"
  default     = ""
}

variable "netmod_jenkins_sub_id" {
  description = "Network module jenkins_sub_id reference"
  default     = ""
}