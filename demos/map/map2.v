fn main() {
	mm := map[string]int{}
	val := mm['bad_key'] or { panic('key not found') }
	println(val)
}
