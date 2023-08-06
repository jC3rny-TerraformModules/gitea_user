
locals {
  gitea_user = {
    for k, v in var.gitea_user : k => {
      active     = coalesce(v.active, true)
      visibility = coalesce(v.visibility, "private")
      #
      username   = coalesce(v.username, k)
      login_name = coalesce(v.login_name, k)
      #
      full_name   = try(v.full_name, "")
      description = try(v.description, "")
      location    = try(v.location, "")
      #
      email = coalesce(v.email, format("%s@%s", coalesce(v.username, k), "gitea.local"))
      #
      password = try(v.password, null)
      #
      must_change_password  = coalesce(v.must_change_password, false)
      force_password_change = coalesce(v.force_password_change, false)
      send_notification     = coalesce(v.send_notification, false)
      #
      admin                     = coalesce(v.admin, false)
      restricted                = coalesce(v.restricted, false)
      prohibit_login            = coalesce(v.prohibit_login, false)
      #
      allow_create_organization = coalesce(v.allow_create_organization, false)
      allow_import_local        = coalesce(v.allow_import_local, true)
      allow_git_hook            = coalesce(v.allow_git_hook, true)
    }
  }
}


resource "random_password" "user" {
  for_each = local.gitea_user
  #
  length           = var.random_password.length
  special          = var.random_password.special
  override_special = var.random_password.override_special
}

resource "gitea_user" "local" {
  for_each = { for k, v in local.gitea_user : k => v }
  #
  active     = each.value.active
  visibility = each.value.visibility
  #
  username   = each.value.username
  login_name = each.value.login_name
  #
  full_name   = each.value.full_name
  description = each.value.description
  location    = each.value.location
  #
  email = each.value.email
  #
  password = coalesce(each.value.password, random_password.user[each.key].result)
  #
  must_change_password  = each.value.must_change_password
  force_password_change = each.value.force_password_change
  send_notification     = each.value.send_notification
  #
  admin                     = each.value.admin
  restricted                = each.value.restricted
  prohibit_login            = each.value.prohibit_login
  #
  allow_create_organization = each.value.allow_create_organization
  allow_import_local        = each.value.allow_import_local
  allow_git_hook            = each.value.allow_git_hook
  #
  depends_on = [
    random_password.user
  ]
}
