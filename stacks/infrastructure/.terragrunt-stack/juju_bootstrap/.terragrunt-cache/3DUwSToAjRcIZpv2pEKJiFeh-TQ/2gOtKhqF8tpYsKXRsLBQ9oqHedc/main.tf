//
// Copyright 2025 Canonical Ltd.  All rights reserved.
//
resource "null_resource" "juju_lxd_bootstrap_controller" {
  provisioner "local-exec" {
    command     = <<-EOT
      set -euo pipefail

      echo ">> Checking if controller exists: ${var.controller_name}"
      if juju controllers --format json | grep -q '"${var.controller_name}"'; then
        echo ">> Controller '${var.controller_name}' already exists, skipping bootstrap."
        exit 0
      fi

      echo ">> Bootstrapping controller '${var.controller_name}'"
      juju bootstrap localhost ${var.controller_name} ${var.bootstrap_args} --constraints ${var.constraints}
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<-EOT
      set -euo pipefail

      echo ">> Destroying Juju controller '${self.triggers.controller_name}'"
      if juju controllers --format json | grep -q '"${self.triggers.controller_name}"'; then
        juju destroy-controller --yes --destroy-all-models --client ${self.triggers.controller_name}
      else
        echo ">> Controller '${self.triggers.controller_name}' not found, skipping destroy."
      fi
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
  triggers = {
    controller_name = var.controller_name
    bootstrap_args  = var.bootstrap_args
  }
}

