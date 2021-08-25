data "openstack_networking_network_v2" "extnet" {
  name = "ext-net"
}

resource "openstack_networking_network_v2" "example_routed_private_network" {
  name = "example_routed_private_network"
}

resource "openstack_networking_subnet_v2" "example_routed_private_subnet" {
  name        = "example_routed_private_subnet"
  network_id  = openstack_networking_network_v2.example_routed_private_network.id
  cidr        = "10.0.2.0/24"
  ip_version  = 4
  enable_dhcp = true
}

resource "openstack_networking_router_v2" "example_router" {
  name                = "example_router"
  external_network_id = data.openstack_networking_network_v2.extnet.id
}

resource "openstack_networking_router_interface_v2" "example_router_interface" {
  router_id = openstack_networking_router_v2.example_router.id
  subnet_id = openstack_networking_subnet_v2.example_routed_private_subnet.id
}

resource "openstack_compute_secgroup_v2" "rules" {
  name        = "terraform__security_group"
  description = "security group for terraform instance"
  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}
