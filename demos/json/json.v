import json

struct Foo {
	x int
}

struct User {
	name      string
	age       int
	foo       Foo    [skip]
	last_name string [json: lastName]
}

data := '{ "name": "Frodo", "lastName": "Baggins", "age": 25 }'
user := json.decode(User, data) or {
	eprintln('Failed to decode json')
	return
}
println(user.name)
println(user.last_name)
println(user.age)
sfoos := '[{"x":123},{"x":456}]'
foos := json.decode([]Foo, sfoos) ?
println(foos[0].x)
println(foos[1].x)
