import math { sqrt }

fn get_hypot(a f64, b f64) f64 {
	c := sqrt(a * a + b * b)
	return c
}

fn main() {
	g := go get_hypot(54.06, 2.08)
	h1 := get_hypot(2.32, 16.74)
	h2 := g.wait()
	println('Results: $h1, $h2')
}
