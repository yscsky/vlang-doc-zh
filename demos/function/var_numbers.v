fn sum(a ...int) int {
	mut total := 0
	for x in a {
		total += x
	}
	return total
}

println(sum()) // 0
println(sum(1)) // 1
println(sum(2, 3)) // 5
a := [2, 3, 4]
println(sum(...a)) // 使用 ... 前缀进行数组分解，output: 9
b := [5, 6, 7]
println(sum(...b)) // output: 18
