struct User {
	age  int
	name string
}

fn main() {
	mut numbers := [1, 3, 2]
	numbers.sort() // 1, 2, 3
	numbers.sort(a > b) // 3, 2, 1
	println(numbers)

	mut users := [User{21, 'Bob'}, User{20, 'Alice'}, User{25, 'Zarkon'}]
	users.sort(a.age < b.age) // 根据 User.age 来排序
	println(users)
	users.sort(a.name > b.name) // 根据 User.name 来反向排序
	println(users)

	mut users2 := [User{21, 'Bob'}, User{65, 'Bob'}, User{25, 'Alice'}]
	custom_sort_fn := fn (a &User, b &User) int {
		// return -1 当 a 在 b 之前
		// return 0, 保持顺序
		// return 1 当 b 在 a 之前
		if a.name == b.name {
			if a.age < b.age {
				return 1
			}
			if a.age > b.age {
				return -1
			}
			return 0
		}
		if a.name < b.name {
			return -1
		} else if a.name > b.name {
			return 1
		}
		return 0
	}
	users2.sort_with_compare(custom_sort_fn)
	println(users2)
}
