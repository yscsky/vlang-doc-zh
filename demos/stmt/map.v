m := map{
	'one': 1
	'two': 2
}
for key, value in m {
	println('$key -> $value')
	// Output: one -> 1
	//         two -> 2
}

for key, _ in m {
	println(key)
	// Output: one
	//         two
}

for _, value in m {
	println(value)
	// Output: 1
	//         2
}
