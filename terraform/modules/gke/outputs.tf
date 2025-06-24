output "cluster_name" {
  description = "Nombre del cluster GKE"
  value       = google_container_cluster.primary.name
}

output "instance_group_url" {
  description = "URL del grupo de instancias"
  value       = google_container_node_pool.primary.instance_group_urls[0]
}