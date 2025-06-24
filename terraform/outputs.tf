output "load_balancer_ip" {
  value = module.load_balancer.ip_address
}
output "bastion_ip" {
  value = module.bastion.ip_address
}
output "cloud_sql_connection" {
  value = module.cloud_sql.connection_name
}