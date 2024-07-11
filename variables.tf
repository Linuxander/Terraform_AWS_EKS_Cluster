# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  description = "This project_name variable is to tag resources."
  default     = "LINUXANDER"
}
