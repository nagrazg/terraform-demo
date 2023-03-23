variable "default_tags" {
    type = map(string)
    description = "(optional) describe your variable"
    default = {
        key1 = "val1"
        key2 = "val2"
    }
}
variable "subnetcount" {
    type = number
    description = "(optional) describe your variable"
    default = 5
}

variable "scount" {
  type = number
  description = "(optional) describe your variable"
}
