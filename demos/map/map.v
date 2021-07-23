fn main() {
	mut m := map[string]int{}
	m['one'] = 1
	m['two'] = 2
	println(m['one']) // "1"
	println(m['bad_key']) // "0"
	println('bad_key' in m) // false
	m.delete('two')

	numbers := map{
		'one': 1
		'two': 2
	}
	println(numbers)

	sm := map{
		'abc': 'xyz'
	}
	val := sm['bad_key']
	println(val) // ''

	intm := map{
		1: 1234
		2: 5678
	}
	s := intm[3]
	println(s) // 0
}
