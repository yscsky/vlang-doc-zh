for i := 0; i < 10; i += 2 {
	// 不打印 6
	if i == 6 {
		continue
	}
	println(i)
}

outer: for i := 4; true; i++ {
	println(i)
	for {
		if i < 7 {
			continue outer
		} else {
			break outer
		}
	}
}
