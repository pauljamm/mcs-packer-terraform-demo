variable "flavor_name" {
  type    = string
  default = "Basic-1-1-10"
}

variable "image_name" {
  type    = string
  default = "nginx"
}

variable "image_tag" {
  type = string
}

variable "node_count" {
  type    = number
  default = 1
}
