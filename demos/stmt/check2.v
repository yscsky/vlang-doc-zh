struct MyStruct {
	x int
}

struct MyStruct2 {
	y string
}

type MySumType = MyStruct | MyStruct2

struct Abc {
	bar MySumType
}

x := Abc{
	bar: MyStruct{123} // MyStruct 会自动转换成 MySumType
}
if x.bar is MyStruct {
	// x.bar 自动被识别
	println(x.bar)
}
match x.bar {
	MyStruct {
		// x.bar 自动被识别
		println(x.bar)
	}
	else {}
}

mut x2 := MySumType(MyStruct{123})
if mut x2 is MyStruct {
	// x 即使是变量也会被识别为 MyStruct，没有 mut 就不会有效
	println(x2)
}
// same with match
match mut x2 {
	MyStruct {
		// x 即使是变量也会被识别为 MyStruct，没有 mut 就不会有效
		println(x2)
	}
	else {}
}
