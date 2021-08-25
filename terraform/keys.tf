resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "openstack_compute_keypair_v2" "ssh" {
  name       = "terraform_ssh_key"
  public_key = tls_private_key.ssh.public_key_openssh
}

output "ssh" {
  value = tls_private_key.ssh.private_key_pem
}
