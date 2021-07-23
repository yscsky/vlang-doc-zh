fn main() {
	mut nums := [1, 2, 3]
	nums << 4
	println(nums) // "[1, 2, 3, 4]"
	// 添加数组
	nums << [5, 6, 7]
	println(nums) // "[1, 2, 3, 4, 5, 6, 7]"

	mut names := ['John']
	names << 'Peter'
	names << 'Sam'
	println(names)
	println(names.len) // "3"
	println('Alex' in names) // "false"
}
