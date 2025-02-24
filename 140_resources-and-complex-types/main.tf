terraform {
  
}

variable "planets" {
	type = list
	default = ["mars","earth","moon"]
}

variable "plans" {
	type = map
	default = {
		"PlanA" = "10 USD",
		"PlanB" = "50 USD",
		"PlanC" = "100 USD"
	}
}

variable "random" {
	type = tuple([string,number,bool])
	default = ["hello",22,false]
}

variable "plan" {
	type = object({
		PlanName = string
		PlanAmount = number
	})

	default = {
		"PlanName" = "Basic",
		"PlanAmount" = 10
	}
}


/*

terraform console

> var.plans
tomap({
  "PlanA" = "10 USD"
  "PlanB" = "50 USD"
  "PlanC" = "100 USD"
})


> var.random
[
  "hello",
  22,
  false,
]


> var.plan
{
  "PlanAmount" = 10
  "PlanName" = "Basic"
}

*/