fn main() {
	arr := [1, 2, 3]
	large_index := 999
	val := arr[large_index] or { panic('out of bounds') }
	println(val)
}
