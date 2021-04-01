locals {
  list_of_maps = [
    {
      a = "list0a",
      b = "list0b"
    },
    {
      a = "list1a",
      b = "list1b"
    }
  ]

  list_of_nested_maps = [
    {
      a = {
        a1 = "a1_value"
        a2 = "a2_value"
      }

      b = {
        b1 = "b1_value"
        b2 = "b2_value"
      }
    },
    {
      a = "list1a_value"
      b = "list1b_value"
    },
  ]

  nested_maps = {
    "map_one" = {
      "item1" = "value1"
      "item2" = "value2"
    }

    "map_two" = {
      "item1" = "value3"
      "item2" = "value4"
    }
  }

}


output "name" {
  value = local.list_of_maps
}

output "list_maps" {
  value = local.list_of_nested_maps
}
output "list_maps_zero" {
  value = local.list_of_nested_maps[0]
}

output "list_maps_zero_a" {
  value = lookup(local.list_of_nested_maps[0], "a")
}

output "nested_maps_1st_map_name" {
  value = element(keys(local.nested_maps), 0)
}


output "nested_maps_2rd_map_name" {
  value = keys(local.nested_maps)
}

output "nested_maps_3rd_map_name" {
  value = local.nested_maps
}


output "nested_maps_1st_map" {
  value = lookup(local.nested_maps, "map_one")
}

output "nested_maps_4st_map" {
  value = lookup(lookup(local.nested_maps, "map_one"), "item1")
}

