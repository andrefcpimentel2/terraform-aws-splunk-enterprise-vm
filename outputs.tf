output "splunk_addr" {
  value = "http://${aws_instance.splunk_ent.public_ip}:8000"
}

output "splunk_username" {
  value = "admin"
}

output "token_value" {
 value = nonsensitive(random_password.password.result)
}

