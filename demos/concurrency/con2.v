import math

fn p(a f64, b f64) {
	c := math.sqrt(a * a + b * b)
	println(c)
}

fn main() {
	h := go p(3, 4)
	h.wait()
}
