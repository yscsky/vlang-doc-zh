import math

fn p(a f64, b f64) {
	c := math.sqrt(a * a + b * b)
	println(c)
}

fn main() {
	go p(3, 4)
}
