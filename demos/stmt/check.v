struct Abc {
	val string
}

struct Xyz {
	foo string
}

type Alphabet = Abc | Xyz

x := Alphabet(Abc{'test'}) // sum type
if x is Abc {
	// x 自动被识别成 Abc，进行使用
	println(x)
}
if x !is Abc {
	println('Not Abc')
}

match x {
	Abc {
		// x 自动被识别成 Abc，进行使用
		println(x)
	}
	Xyz {
		// x 自动被识别成 Xyz，进行使用
		println(x)
	}
}
