variable "default_tags" {
    type = map(string)
    description = "(optional) describe your variable"
    default = {
        key1 = "val1"
        key2 = "val2"
    }
}
variable "azcount" {
    type = number
    description = "(optional) describe your variable"
    default = 6
}

variable "pbsubnetcount" {
    type = number
    description = "(optional) describe your variable"
    default = 8
}
