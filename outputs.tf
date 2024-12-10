output "splunk_addr" {
  value = aws_instance.splunk_ent.public_ip
}

output "splunk_username" {
  value = "admin"
}

output "splunk_password" {
  value = "SPLUNK-${aws_instance.splunk_ent.id}"
}

