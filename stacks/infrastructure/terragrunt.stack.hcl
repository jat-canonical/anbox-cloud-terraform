unit "juju_bootstrap" {
  source = find_in_parent_folders("catalog/units/juju_bootstrap")
  path   = "juju_bootstrap"

  values = {
    controller_name = "lxd"
    constraints     = "tags=\"juju\""
  }
}

