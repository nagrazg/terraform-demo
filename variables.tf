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


variable "az" {
  type = list(string)
  description = "(optional) describe your variable"
  default = [ "us-east-1a", "us-east-1b","us-east-1c" ]
}
