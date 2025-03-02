variable "image_id" {
type = string  
description = "This is docker image id"
default = "ubuntu"

}
variable "image_web" {
type = string
description = "web server"
default = "httpd"

}
variable "command" {
  type        = list(string)
  description = "Command to run in the container"
#   default     = ["/bin/sh", "-c", "while true; do sleep 1000; done"]
}
variable "env" {
    type = list(string)
    description = "env for dev"
}
variable "mysql_image" {
  description = "MySQL Docker image version"
  type        = string
  default     = "mysql"
}
variable "mysql_root" {
  description = "mysql password"
  type = list(string)
  
}
variable "pipline_image" {
  description = "pipline"
  type = string

  
}
variable "pma_image" {
  description = "pma"
  type = string
  
}