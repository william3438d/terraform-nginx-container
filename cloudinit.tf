# Cloudinit file for Web Server.

# Installation scripts
data "template_file" "init-script" {
  template = file("scripts/init.cfg")
}

# Template for Web Server
data "template_cloudinit_config" "init-web" {
  gzip          = false
  base64_encode = false
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init-script.rendered
  }
}
