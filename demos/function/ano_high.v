fn sqr(n int) int {
	return n * n
}

fn cube(n int) int {
	return n * n * n
}

fn run(value int, op fn (int) int) int {
	return op(value)
}

fn main() {
	println(run(5, sqr)) // "25"

	double_fn := fn (n int) int {
		return n + n
	}
	println(run(5, double_fn)) // "10"

	res := run(5, fn (n int) int {
		return n + n
	})
	println(res) // "10"

	fns := [sqr, cube]
	println(fns[0](10)) // "100"
	fns_map := map{
		'sqr':  sqr
		'cube': cube
	}
	println(fns_map['cube'](2)) // "8"
}
