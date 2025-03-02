terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# resource "docker_image" "httpd" {
#   name         = "httpd"
#   keep_locally = false
# }
# Define the Ubuntu Docker image

# Define the container using the Ubuntu image
# Create a Docker Network
resource "docker_network" "custom_network" {
  name   = "custom"
  driver = "bridge"
}

resource "docker_container" "pipline" {
  name = "pipline"
  image = var.pipline_image
  ports {
    internal = 8080
    external = 8080
  }
  ports {
    internal = 50000
    external = 50000
  }
}
resource "docker_container" "pma" {
  name = "pma"
  image = var.pma_image
  ports {
    internal = 80
    external = 9090
  }
  env = [ "PMA_ARBITRARY=1" ]
  network_mode = "bridge"
  hostname = "pma"
   networks_advanced {
    name = docker_network.custom_network.name
  }
}
resource "docker_container" "mysql" {
  name  = "mysql"
  image = var.mysql_image
   ports {
    internal = 3306
    external = 3306
  }
  env = var.mysql_root
  network_mode = "bridge"
  hostname = "mysql"
   networks_advanced {
    name = docker_network.custom_network.name
  }
}
resource "docker_container" "httpd" {
  image = var.image_web
  name  = "server"
  hostname = "server"

  ports {
    internal = 3005
    external = 8000
  }
   ports {
    internal = 3005
    external = 3005
  }
  env = var.env
  user = "node"
  lifecycle {
    prevent_destroy = true
  ignore_changes = [
    image,   # Prevents Terraform from recreating the container when the image hash changes
    command,
    entrypoint,
    hostname,
    id,
    init,
    ipc_mode,
    log_driver,
    network_mode,
    runtime,
    security_opts,
    shm_size,
    stop_signal,
    stop_timeout,
  ]
}
}
# resource "docker_image" "ubuntu" {
#     name = "ubuntu"
    
# }
resource "docker_container" "ubuntu" {
    name = "ubuntu"
    command = var.command
    image = var.image_id
 lifecycle {
  ignore_changes = [
    image,   # Prevents Terraform from recreating the container when the image hash changes
    command,
    entrypoint,
    hostname,
    id,
    init,
    ipc_mode,
    log_driver,
    network_mode,
    runtime,
    security_opts,
    shm_size,
    stop_signal,
    stop_timeout,
  ]
}
}
# Start a container
# resource "docker_container" "alpine" {
#   name  = "alpine"
#   command = ["/bin/sh", "c", "while true; do sleep 1000; done"]
#   image = docker_image.alpine.name
# }

# # Find the latest Ubuntu precise image.
# resource "docker_image" "alpine" {
#   name = "alpine"
# }