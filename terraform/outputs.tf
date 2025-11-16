output "container_nginx" {
  value       = docker_container.nginx.name
  description = "Nginx container name"
}

output "container_php" {
  value       = docker_container.php.name
  description = "PHP container name"
}

