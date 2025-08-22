variable "controller_name" {
  type        = string
  description = "Name of the Juju controller to create"
  default     = "juju-maas"
}

variable "bootstrap_args" {
  type        = string
  description = "Extra args to pass to juju bootstrap (e.g., --model-default)"
  default     = ""
}

variable "constraints" {
  type        = string
  description = "Constraints for the controller"
  default     = ""
}

