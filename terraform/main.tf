resource "openstack_compute_instance_v2" "instance" {
  count = var.node_count

  name = "node-${count.index}"

  image_name = "${var.image_name}-${var.image_tag}"

  flavor_name = var.flavor_name

  key_pair = openstack_compute_keypair_v2.ssh.name

  config_drive = true

  security_groups = [
    openstack_compute_secgroup_v2.rules.name
  ]

  network {
    name = openstack_networking_network_v2.example_routed_private_network.name
  }

  lifecycle {
    create_before_destroy = true
  }
}
