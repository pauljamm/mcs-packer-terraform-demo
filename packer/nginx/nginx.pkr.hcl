variable "image_tag" {
  type = string
}

source "openstack" "nginx" {
  source_image_filter {
    filters {
      name = "Centos-7.9-202107"
    }
    most_recent = true
  }

  flavor                  = "Basic-1-1-10"
  ssh_username            = "centos"
  security_groups         = ["all"]
  volume_size             = 10
  config_drive            = "true"
  use_blockstorage_volume = "true"
  networks                = ["298117ae-3fa4-4109-9e08-8be5602be5a2"]

  image_name = "nginx-${var.image_tag}"
}

build {
  sources = ["source.openstack.nginx"]

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }

}
