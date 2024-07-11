locals {
  bitbucket_ips = [
    "104.192.136.0/21",
    "185.166.140.0/22",
    "18.205.93.0/25",
    "18.234.32.128/25",
    "13.52.5.0/25",
  ]
  allowed_ips_for_jenkins_server = [for ip in split("\n", trimspace(file("${path.module}/data/allowed_ips_for_jenkins_server.txt"))) : ip]
  allowed_ips_for_http           = [for ip in split("\n", trimspace(file("${path.module}/data/allowed_ips_for_http.txt"))) : ip]
  allowed_ips_for_ssh            = [for ip in split("\n", trimspace(file("${path.module}/data/allowed_ips_for_ssh.txt"))) : ip]
}