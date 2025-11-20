terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.12.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_network" "web" {
  name = "${var.project_name}-network"
}

resource "docker_volume" "www" {
  name = "${var.project_name}-www"
}

resource "docker_image" "php" {
  name = "php:8.2-fpm-alpine"
}

resource "docker_image" "nginx" {
  name = "nginx:1.29.3-alpine"
}

resource "docker_container" "nginx" {
  image        = docker_image.nginx.latest
  name         = "${var.project_name}-nginx"
  network_mode = "bridge"
  networks_advanced {
    name = docker_network.web.name
  }
  ports {
    internal = 80
    external = var.host_port
  }
  volumes {
    container_path = "/usr/share/nginx/html"
    volume_name    = docker_volume.www.name
  }
}

resource "docker_container" "php" {
  image        = docker_image.php.latest
  name         = "${var.project_name}-php"
  env          = ["APP_ENV=${var.app_env}"]
  network_mode = "bridge"
  networks_advanced {
    name = docker_network.web.name
  }
  volumes {
    container_path = "/var/www/html"
    volume_name    = docker_volume.www.name
  }
}

