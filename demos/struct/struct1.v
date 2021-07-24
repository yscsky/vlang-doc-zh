struct ButtonConfig {
	text        string
	is_disabled bool
	width       int = 70
	height      int = 20
}

struct Button {
	text   string
	width  int
	height int
}

fn new_button(a string, c ButtonConfig) &Button {
	println(a)
	return &Button{
		width: c.width
		height: c.height
		text: c.text
	}
}

button := new_button('hello', text: 'Click me', width: 100)
assert button.height == 20
