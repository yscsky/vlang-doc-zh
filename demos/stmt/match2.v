enum Color {
	red
	blue
	green
}

fn is_red_or_blue(c Color) bool {
	return match c {
		.red, .blue { true }
		.green { false }
	}
}

fn main() {
	println(is_red_or_blue(.red))
	println(is_red_or_blue(.blue))
	println(is_red_or_blue(.green))

	colors := [Color.red, Color.blue, Color.green]
	for c in colors {
		s := match c {
			.red { 'red' }
			.blue { 'blue' }
			.green { 'green' }
		}
		println(s)
	}
}
