
# random_password
variable "random_password" {
  type = object({
      length           = optional(number)
      special          = optional(bool)
      override_special = optional(string)
  })
  #
  default = {
    length = 20
    special = false
    override_special = ""
  }
}

# gitea_user
variable "gitea_user" {
  type = map(object({
    active     = optional(bool)
    visibility = optional(bool)
    #
    username   = optional(string)
    login_name = optional(string)
    #
    full_name   = optional(string)
    description = optional(string)
    location    = optional(string)
    #
    email = optional(string)
    #
    password = optional(string)
    #
    must_change_password  = optional(bool)
    force_password_change = optional(bool)
    send_notification     = optional(bool)
    #
    admin                     = optional(bool)
    restricted                = optional(bool)
    prohibit_login            = optional(bool)
    #
    allow_create_organization = optional(bool)
    allow_import_local        = optional(bool)
    allow_git_hook            = optional(bool)
  }))
  #
  default = {}
}
