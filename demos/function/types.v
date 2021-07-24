// 使用类型别名来命名一个函数签名:
type Filter = fn (string) string

// 函数可以使用函数类型作为参数:
fn filter(s string, f Filter) string {
	return f(s)
}

// 声明相同签名函数:
fn uppercase(s string) string {
	return s.to_upper()
}

fn main() {
	my_filter := Filter(uppercase)

	println(filter('Hello world', my_filter))
	println(filter('Hello world', uppercase))
	println(filter('Hello world', fn (s string) string {
		return s.to_upper()
	}))
}
