terraform {

}

variable "str" {
	type = string
	default = ""
}
variable "items" {
	type = list
	default = [null,null,"","last"]
}

variable "stuff" {
	type = map
	default = {
		"hello" = "world",
		"goodbye" = "moon"
	}
}

/*

# Built-in Functions
terraform console


> var.str
""
>


> var.items
tolist([
  tostring(null),
  tostring(null),
  "",
  "last",
])
>



> var.stuff
tomap({
  "goodbye" = "moon"
  "hello" = "world"
})

> keys(var.stuff)
tolist([
  "goodbye",
  "hello",
])

> uuid()
"2ac8cd41-012b-23c3-f438-355b9017fdee"


> bcrypt("hello world")
"$2a$10$v7qCEHwDi9g8jvIZRVFWIOcjAYZDNcv2KE6L7frM9Ldsk2ap/DQCK"

> cidrsubnet("172.16.0.0/12", 4,2)
"172.18.0.0/16"

*/