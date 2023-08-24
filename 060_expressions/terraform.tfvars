/*
hello="world"


> " Hello ${var.hello}!"
" Hello world!"
*/


/*
hello="barsoon"

"Hello %{if var.hello == "barsoon"}Mars%{else}World%{endif}"
"Hello Mars"
*/


/*

worlds=["barsoon","jassom", "sasoom", "cossom"]

> [for w in var.worlds : upper(w)]
[
  "BARSOON",
  "JASSOM",
  "SASOOM",
  "COSSOM",
]
*/

/*

worlds_map={
    "barsoon" = "mars",
    "jassom" = "jupiter",
    "sasoom" = "saturn",
    "cossom" = "pluto"
}

> [for k,v in var.worlds_map : upper(v)]
[
  "MARS",
  "PLUTO",
  "JUPITER",
  "SATURN",
]

> [for k,v in var.worlds_map : upper(k) if v == "mars"]
[
  "BARSOON",
]

*/




 
/*
worlds_splat=[
    {mars_name="barsoon", earth_name= "mars"},
    {mars_name="jassom", mars_name= "jupiter"},
    {mars_name="sasoom", mars_name= "saturn"},
    {mars_name="cossom", mars_name= "pluto"}
]


> var.worlds_splat
tolist([
  tomap({
    "earth_name" = "mars"
    "mars_name" = "barsoon"
  }),
  tomap({
    "mars_name" = "jupiter"
  }),
  tomap({
    "mars_name" = "saturn"
  }),
  tomap({
    "mars_name" = "pluto"
  }),
])
>

> [for m in var.worlds_splat : m.mars_name]
[
  "barsoon",
  "jupiter",
  "saturn",
  "pluto",
]



> var.worlds_splat[*].mars_name
tolist([
  "barsoon",
  "jupiter",
  "saturn",
  "pluto",
])


*/