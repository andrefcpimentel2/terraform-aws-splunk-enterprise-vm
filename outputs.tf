output "splunk_addr" {
  value = aws_instance.splunk_ent.public_ip
}

output "splunk_username" {
  value = "admin"
}

output "token_value" {
 value = nonsensitive(random_password.password.result)
}

