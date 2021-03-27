locals {
  letters = ["c", "a", "t"]

  cat = {
    name   = "neko",
    gender = "male"
  }
}
output "upper-case-list" {
  value = [for l in local.letters : upper(l)]
}

output "upper-case-map" {
  value = { for entry in local.cat :
    entry => upper(entry)
  }
}
