fn main() {
	println(add(77, 33))
	println(sub(100, 50))

	a, b := foo()
	println(a) // 2
	println(b) // 3
	c, _ := foo() // 忽略返回值使用 `_`
	println(c)
}

fn add(x int, y int) int {
	return x + y
}

fn sub(x int, y int) int {
	return x - y
}

fn foo() (int, int) {
	return 2, 3
}
