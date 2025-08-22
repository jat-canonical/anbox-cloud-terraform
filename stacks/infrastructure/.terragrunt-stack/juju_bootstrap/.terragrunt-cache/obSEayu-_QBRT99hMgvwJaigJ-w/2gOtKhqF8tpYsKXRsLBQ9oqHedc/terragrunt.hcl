include "root" {
  path = "${find_in_parent_folders("root.hcl")}"
}

terraform {
  source = "${find_in_parent_folders("catalog/modules/juju_lxd_bootstrap")}"
}

