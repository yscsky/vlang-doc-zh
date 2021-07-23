numbers := [1, 2, 3, 4, 5]
for num in numbers {
	println(num)
}
names := ['Sam', 'Peter']
for i, name in names {
	println('$i) $name')
	// Output: 0) Sam
	//         1) Peter
}

mut numbers2 := [0, 1, 2]
for mut num in numbers2 {
	num++
}
println(numbers2) // [1, 2, 3]

for num in 1 .. 10 {
	print(num)
}
println('')
