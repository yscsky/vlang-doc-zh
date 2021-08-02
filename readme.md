# vlang 中文文档

翻译自：[vlang doc](https://github.com/vlang/v/blob/master/doc/docs.md)

# 介绍

V 是一门静态编译型语言，设计用来构建可维护的软件 。与 Go 相似，同时设计时参考了 Oberon，Rust，Swift，Kotlin，Python。

V 是一门十分简单的语言，花点时间看完整篇文档，也就基本掌握了 V。如果熟悉 Go，那就已经掌握了 80%。

V 推崇以最小的抽象来写简单干净的代码。除了简单外，V 也能给予开发者很大的能力，所有能用其它语言实现的都能用 V 实现。

# 安装

最主要的安装方式是从源码安装，既简单又十分快（几秒即可）。

## Linux, macOS, FreeBSD 等

首先需要 git，和 C 编译器，例如：tcc，gcc 或 clang，还有 make：

```shell
git clone https://github.com/vlang/v
cd v
make
# 创建链接
sudo ./v symlink
```

## Windows

首先需要 git，和 C 编译器，例如：tcc，gcc 或 clang，还有 msvc：

```shell
git clone https://github.com/vlang/v
cd v
make.bat -tcc
```

make.bat 后面也可以传递其它参数：-gcc，-msvc，-clang，来使用其它 C 编译器。但 -tcc 更小，容易安装（ V 会自动下载预编译的二进制）。

推荐将 v 目录添加到环境变量中，这样可以执行 `v.exe symlink`。

## Android

可以通过 vab 安装 v 图形应用到 Android 上，

V Android 依赖：**V**, **Java JDK** >= 8, Android **SDK + NDK**.

1. 安装依赖 (see [vab](https://github.com/vlang/vab))
2. 连接你的安卓设备
3. 运行:

```shell
git clone https://github.com/vlang/vab && cd vab && v vab.v
./vab --device auto run /path/to/v/examples/sokol/particles
```

更多细节：[vab GitHub repository](https://github.com/vlang/vab)。

# Hello World

```v
fn main() {
	println('hello world')
}
```

将上述代码保存到 `hello.v`，再运行 `v run hello.v`：

```shell
v run hello.v
hello world
```

恭喜，成功运行了第一个 V 程序。

通过 `v hello.v` 编译 `hello.v`，生成 hello 的二进制文件，直接运行 `./hello`。更多 v 指令说明可通过 `v help` 查看。

上述代码中，通过 `fn` 声明了一个名为 main 的函数，返回类型定义在函数名之后，main 函数没有返回任何东西，所以 main 函数没有定义返回类型。

和其它语言（例如 C，Go 和 Rust）一样，main 函数是整个程序的入口。

`println` 是内建函数，用来打印内容到标准输出上，一般就是输出到命令行上。

在单文件的程序中，`fn main()` 可以被省略，在写类似脚本的代码或学习代码时十分便利。因此，为了简洁，下面教程中会省略 `fn main()`。

所以上述代码，可以省略成：

```v
println('hello world')
```

一样可以通过 v run 运行。

# 运行多个文件

在一个文件夹中有多个文件，其中 1 个包含 main 函数，其它是辅助函数，想要将这个几个文件编译成一个可执行文件，可以通过 `v run .`，如果带参数：`v run . --yourparam some_other_stuff`。

上述命令首先会编译生成可执行文件，然后将--yourparam some_other_stuff 作为命令行参数传递到程序中。

程序中可以通过下列方式使用命令行参数：

```v
import os

println(os.args)
```

注意当程序执行完后，会删除可执行文件，如果需要保留的话：

```shell
v -keepc run .
# 或者手动编译
v .
```

注意：任何编译参数要放在 run 之前，任何程序执行参数，放在源码之后，参数会原样传递给程序，v 命令不会处理。

# 注释

```v
// 这是单行注释
/*
这是多行注释
   /* 可以内嵌 */
*/
```

# 函数

```v
fn main() {
	println(add(77, 33))
	println(sub(100, 50))
}

fn add(x int, y int) int {
	return x + y
}

fn sub(x int, y int) int {
	return x - y
}
```

变量类型在变量名之后。

与 Go 和 C 一样，函数不能重载，这样简化能提高代码的可维护性和可读性。

函数可以在声明前就使用，例如 add 和 sub 代码在 main 之后，但是 main 中可以调用。这适用于 V 中的所有声明，并且不需要头文件或考虑文件和声明的顺序。

## 多返回值

```v
fn foo() (int, int) {
	return 2, 3
}

a, b := foo()
println(a) // 2
println(b) // 3
c, _ := foo() // 忽略返回值使用 `_`
```

# 符号可见性

```v
pub fn public_function() {
}

fn private_function() {
}
```

函数默认是私有的不对外暴露，要使得其它模块可以使用，需要前置 `pub`，对于常量和类型都一样。

注意：`pub` 只能用于被命名的模块，如何创建模块参见[模块](#模块)。

# 变量

```v
name := 'Bob'
age := 20
large_number := i64(9999999999)
println(name)
println(age)
println(large_number)
```

使用 `:=` 声明和初始化变量，这也是 V 中唯一的声明方式，这也说明变量都有初始值。

变量类型可以从右边值中推导出来，转换类型的话，通过 `T(v)` 将 v 值转为 T 类型。

不同于其它语言，V 只能在函数中声明变量，全局(模块)变量是不存在的，在 V 中是没有全局状态，详细说明参见：[默认为纯函数](#默认为纯函数)。

为保证代码风格的一致性，所有的变量和函数名都使用 `snake_case` 的样式，而类型名则使用 `PascalCase` 的样式。

## 可变变量

```v
mut age := 20
println(age)
age = 21
println(age)
```

改变变量的值使用 `=`，在 V 中，变量默认是不可变的。如果要可改变，则在变量声明时加 `mut`。

可以将上面代码中第一行的 mut 去除编译试试。

## 初始化 vs 赋值

注意区分 `:=` 和 `=`， `:=` 是用来声明和初始化变量， `=` 是用来赋值。

```v
fn main() {
	age = 21
}
```

这个代码是编译不通过的，age 没有声明，所有变量在 V 中都要被声明。

```v
fn main() {
	age := 21
}
```

多个变量值可以在一行代码中改变。这样，交换变量值可以不用中间变量来实现。

```v
mut a := 0
mut b := 1
println('$a, $b') // 0, 1
a, b = b, a
println('$a, $b') // 1, 0
```

## 变量声明的错误

在开发模式中，未使用的变量编译器会发出警告，"unused variable"。在生产模式中，则完全不会被编译。生产模式使用：`v -prod foo.v`，编译时设置 `-prod`。

```v
fn main() {
	a := 10
	if true {
		a := 20 // error: redefinition of `a`
	}
	// warning: unused variable `a`
}
```

不同与其它语言，变量遮蔽是不允许的。在外部代码块中已经声明了一个变量，在其内部代码块中，不能再声明同名的变量，编译会报错。

但是允许遮蔽模块名，因为在某些情况下非常有用：

```v
import ui
import gg

fn draw(ctx &gg.Context) {
	gg := ctx.parent.get_ui().gg
	gg.draw_rect(10, 10, 100, 50)
}
```

# V 类型

## 原始类型

```v
bool

string

i8    i16  int  i64
byte  u16  u32  u64

rune // Unicode字符

f32 f64

voidptr, size_t // 主要和 C 交互使用

any // 类似于 C 的 void* 和 Go 的 interface{}
```

注意不同于 C 和 Go，int 都是 32 位整型。

V 中所有操作要求两边数据类型都要一致，小的类型可以自动提升到符合的大的类型，转化规则如下：

```v
   i8 → i16 → int → i64
                  ↘     ↘
                    f32 → f64
                  ↗     ↗
 byte → u16 → u32 → u64 ⬎
      ↘     ↘     ↘      ptr
   i8 → i16 → int → i64 ⬏
```

例如 int 可以自动转换为 i64 和 f64，但是不能为 u32，会丢失符号位。int 转化 f32 是可以的，但是大数值的话会丢失精度。

字面值 123 会默认为 int，4.56 会默认为 f64。除非指定类型：

```v
u := u16(12)
v := 13 + u    // v is of type `u16` - 不变更
x := f32(45.6)
y := x + 3.14  // x is of type `f32` - 不变更
a := 75        // a is of type `int` - 默认 int
b := 14.7      // b is of type `f64` - 默认 float
c := u + a     // c is of type `int` - u 会自动转换为 int
d := b + x     // d is of type `f64` - x 会自动转换为 f64
```

## 字符串

```v
name := 'Bob'
println(name.len)
println(name[0]) // 字符串索引为 0 的字节 B
println(name[1..3]) // 索引 1 到 3 的子字符串 'ob'
windows_newline := '\r\n' // 转译字符
assert windows_newline.len == 2
```

V 中字符串是只读的字节数组，由 UTF-8 编码，其值是不可变的，不能改变其中值：

```v
mut s := 'hello 🌎'
s[0] = `H` // 不允许
```

注意索引字符串生成的是 `byte` 不是 `rune`。

`rune` 类型要使用 ` :

```v
rocket := `🚀`
assert 'aloha!'[0] == `a`
```

单引号和双引号都可以用来表示字符串。 为保持一致性，除非字符串包含单引号，否则 vfmt 会将双引号转换为单引号。

原始字符串需要前置 r，原始字符串中字符不会被转译：

```v
s := r'hello\nworld'
println(s) // "hello\nworld"
```

字符串可以很简单的转换成数字：

```v
s := '42'
n := s.int() // 42
```

## Runes

`rune` 表示 unicode 字符，是 `u32` 的别名。 创建方式：

```v
x := `🚀`
```

字符串可以通过 `.runes()` 方法转换成 runes：

```v
hello := 'Hello World 👋'
hello_runes := hello.runes() // [`H`, `e`, `l`, `l`, `o`, ` `, `W`, `o`, `r`, `l`, `d`, ` `, `👋`]
```

## 字符串插值

在字符串中插值，在变量前使用 $，变量会转换为字符串：

```v
name := 'Bob'
println('Hello, $name!') // Hello, Bob!
```

同样适用于字段：`'age = $user.age'`，更复杂的表达式需要使用 `${}`：`'can register = ${user.age > 13}'`。

格式化方式类似 C 的 `printf()` 同样支持 `f`, `g`, `x` 等格式化输出字符串。编译器负责存储大小，所以没有 `hd` or `llu`。

```v
x := 123.4567
println('x = ${x:4.2f}') // 123.46
println('[${x:10}]') // 在左侧加空格 => [   123.457]
println('[${int(x):-10}]') // 在右侧加空格 => [123       ]
println('[${int(x):010}]') // 用 0 填充空格 => [0000000123]
```

## 字符串操作

```v
name := 'Bob'
bobby := name + 'by' // + 用来串联字符串
println(bobby) // "Bobby"
mut s := 'hello '
s += 'world' // `+=` 用来追加字符串
println(s) // "hello world"
```

不能用一个整型加到字符串上：

```v
age := 10
println('age = ' + age) // error: infix expr: cannot use int (right expression) as string
```

要么将整型转换成字符串：

```v
age := 11
println('age = ' + age.str())
```

要么使用字符串插值：

```v
age := 12
println('age = $age')
```

## 数值

```v
a := 123
```

将 123 赋值给 a，a 默认是 int 类型。

也可以使用十六进制，二进制或八进制的标记法赋值：

```v
a := 0x7B
b := 0b01111011
c := 0o173
```

所有变量的值都是 123，都是 int，不管用什么标记方式。

V 也支持用 \_ 分割数字：

```v
num := 1_000_000 // same as 1000000
three := 0b0_11 // same as 0b11
float_num := 3_122.55 // same as 3122.55
hexa := 0xF_F // same as 255
oct := 0o17_3 // same as 0o173
```

需要设置不同类型的数字，则明确设置类型：

```v
a := i64(123)
b := byte(42)
c := i16(12345)
```

浮点数的设置方式类似，不指定类型默认使 f64：

```v
f := 1.0
f1 := f64(3.14)
f2 := f32(3.14)
```

## 数组

### 基本数组概念

数组是一系列相同类型的元素的集合，描述方式使用方括号包含一串元素。其中元素可以通过方括号内的索引(从 0 开始)访问：

```v
mut nums := [1, 2, 3]
println(nums) // `[1, 2, 3]`
println(nums[0]) // `1`
println(nums[1]) // `2`
nums[1] = 5
println(nums) // `[1, 5, 3]`
```

### 数组属性

有两个属性控制数字的“长度”：

- `len`：长度 - 数组预先分配和初始化元素的数量
- `cap`：容量 - 预分配的内存空间大小，但没有被初始化或计算使用。数组可以增长到这个大小无需重新分配。通常 V 会自动管理这个属性，但是用户可以手动设置。

```v
mut nums := [1, 2, 3]
println(nums.len) // "3"
println(nums.cap) // "3" 或更多
nums = [] // 数组现在是空的
println(nums.len) // "0"
```

注意，数组的属性是只读的，用户不能修改。

### 数组初始化

基本语法如上描述，数组的类型由第一个元素决定：

- `[1, 2, 3]` 是一个整型数组 (`[]int`)。
- `['a', 'b']` 是一个字符串数组 (`[]string`)。

也可以明确指定第一个元素的类型：`[byte(16), 32, 64, 128]`。V 的数组都是同类型的，所有元素类型都相同，所以像 `[1, 'a']` 这样的是编译不通过的。

对于非常大或者空数组有另一种初始化方式：

```v
mut a := []int{len: 10000, cap: 30000, init: 3}
```

创建了一个 10000 个元素的整型数组，并初始化了 3 个元素。内存中分配了 30000 个元素大小的空间。参数 `len`，`cap` 和 `init`都是可选的；`len` 默认是 0，`init` 默认值是类型的默认值（数值是 `0`，字符串是 `''` ）。系统运行时会确保 `cap` 不会小于 `len`（即使声明设置的较小）：

```v
arr := []int{len: 5, init: -1}
// `arr == [-1, -1, -1, -1, -1]`, arr.cap == 5

// 声明一个空数组
users := []int{}
```

设置容量可以提高性能，避免添加元素时数组内存的再分配：

```v
mut numbers := []int{cap: 1000}
println(numbers.len) // 0
// 添加元素时不会重新分配内存
for i in 0 .. 1000 {
	numbers << i
}
```

注意：上述代码中使用了 [range for](#range for) 的表达式和[ << 操作符](#数组操作符)。

### 数组类型

一个数组可以使用以下类型：

| Types        | Example Definition                   |
| ------------ | ------------------------------------ |
| Number       | `[]int,[]i64`                        |
| String       | `[]string`                           |
| Rune         | `[]rune`                             |
| Boolean      | `[]bool`                             |
| Array        | `[][]int`                            |
| Struct       | `[]MyStructName`                     |
| Channel      | `[]chan f64`                         |
| Function     | `[]MyFunctionType` `[]fn (int) bool` |
| Interface    | `[]MyInterfaceName`                  |
| Sum Type     | `[]MySumTypeName`                    |
| Generic Type | `[]T`                                |
| Map          | `[]map[string]f64`                   |
| Enum         | `[]MyEnumType`                       |
| Alias        | `[]MyAliasTypeName`                  |
| Thread       | `[]thread int`                       |
| Reference    | `[]&f64`                             |
| Shared       | `[]shared MyStructType`              |

例程：

这个例子使用[结构体](#结构体)和[联合类型](#联合类型)来创建数组。

```v
struct Point {
	x int
	y int
}

struct Line {
	p1 Point
	p2 Point
}

type ObjectSumType = Line | Point

mut object_list := []ObjectSumType{}
object_list << Point{1, 1}
object_list << Line{
	p1: Point{3, 3}
	p2: Point{4, 4}
}
dump(object_list)
/*
object_list: [ObjectSumType(Point{
    x: 1
    y: 1
}), ObjectSumType(Line{
    p1: Point{
        x: 3
        y: 3
    }
    p2: Point{
        x: 4
        y: 4
    }
})]
*/
```

### 多维数组

二维数组：

```v
mut a := [][]int{len: 2, init: []int{len: 3}}
a[0][1] = 2
println(a) // [[0, 2, 0], [0, 0, 0]]
```

三维数组：

```v
mut a := [][][]int{len: 2, init: [][]int{len: 3, init: []int{len: 2}}}
a[0][1][1] = 2
println(a) // [[[0, 0], [0, 2], [0, 0]], [[0, 0], [0, 0], [0, 0]]]
```

### 数组操作符

使用 `<<` 推送操作符将一个元素或一个数组加到另一个数组尾部。

```v
mut nums := [1, 2, 3]
nums << 4
println(nums) // "[1, 2, 3, 4]"
// 添加数组
nums << [5, 6, 7]
println(nums) // "[1, 2, 3, 4, 5, 6, 7]"
mut names := ['John']
names << 'Peter'
names << 'Sam'
// names << 10  <-- 无法编译，names是字符串数组
```

使用 [in 操作符](#in 操作符) 可以判断一个元素是否在一个数组中：

```v
names := ['John', 'Peter', 'Sam']
println(names.len) // "3"
println('Alex' in names) // "false"
```

### 数组方法

所有数组可以 `println(arr)` 打印，通过 `s := arr.str()` 转换成字符串。

复制数组使用 `.clone()`：

```v
nums := [1, 2, 3]
nums_copy := nums.clone()
```

使用 `.filter()` 和`.map()` 方法可以高效的过滤和遍历数组：

```v
nums := [1, 2, 3, 4, 5, 6]
even := nums.filter(it % 2 == 0)
println(even) // [2, 4, 6]
// 通过匿名函数过滤
even_fn := nums.filter(fn (x int) bool {
	return x % 2 == 0
})
println(even_fn)
words := ['hello', 'world']
upper := words.map(it.to_upper())
println(upper) // ['HELLO', 'WORLD']
// 通过匿名函数遍历
upper_fn := words.map(fn (w string) string {
	return w.to_upper()
})
println(upper_fn) // ['HELLO', 'WORLD']
```

`it` 是内建变量来指代当前过滤或遍历过程中的元素。

另外，还提供了`.any()` 和`.all()` 方法可以便利的测试当前元素是否满足一个条件：

```v
nums := [1, 2, 3]
println(nums.any(it == 2)) // true
println(nums.all(it >= 2)) // false
```

下面是数组内建的方法：

- `b := a.repeat(n)` 将 a 数组的元素重复 n 次放入 b 数组
- `a.insert(i, val)` 在 i 位置插入 val，并将后续元素依次往后移
- `a.insert(i, [3, 4, 5])` 从 i 位置开始插入数组
- `a.prepend(val)` 将 val 插入到数组头部，等价于 `a.insert(0, val)`
- `a.prepend(arr)` 将 arr 数组插入到数组头部
- `a.trim(new_len)` 裁剪 new_len 长度的数组，只有 new_len 小于当前数组长度时有效
- `a.clear()`清空数组（不会改变 `cap`，等价于`a.trim(0)`）
- `a.delete_many(start, size)` 从 start 开始删除 size 大小的连续的数组，会触发重新分配
- `a.delete(index)` 删除 index 处的元素，等价于 `a.delete_many(index, 1)`
- `v := a.first()` 等价于 `v := a[0]`
- `v := a.last()` 等价于 `v := a[a.len - 1]`
- `v := a.pop()` 获取最后一个元素，并从数组中移除
- `a.delete_last()` 移除最后一个元素
- `b := a.reverse()` 生成 a 的反序数组
- `a.reverse_in_place()` 在 a 中将元素的顺序调转
- `a.join(joiner)` 使用`joiner`字符串作为分隔符将字符串数组连接成一个字符串

### 排序数组

排序数组的方式十分简单和直观，特别定义了 `a` 和 `b` 来支持自定义排序条件。

```v
mut numbers := [1, 3, 2]
numbers.sort() // 1, 2, 3
numbers.sort(a > b) // 3, 2, 1
```

```v
struct User {
	age  int
	name string
}

mut users := [User{21, 'Bob'}, User{20, 'Zarkon'}, User{25, 'Alice'}]
users.sort(a.age < b.age) // 根据 User.age 来排序
users.sort(a.name > b.name) // 根据 User.name 来反向排序
```

V 支持自定义排序，通过 `sort_with_compare` 方法实现，适用于需要通过多个字段来排序的情况。下面的代码就通过 name 来正向排序，age 来反向排序：

```v
struct User {
	age  int
	name string
}

mut users := [User{21, 'Bob'}, User{65, 'Bob'}, User{25, 'Alice'}]

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
users.sort_with_compare(custom_sort_fn)
```

### 数组切片

切片是一个数组的部分，初始化的方式是在索引值之间通过 `..` 操作符生成，右侧的索引值必须大于或等于左侧值。

如果右侧值省略，则默认是数组长度；左侧值省略默认是 0。

```v
nums := [0, 10, 20, 30, 40]
println(nums[1..4]) // [10, 20, 30]
println(nums[..4]) // [0, 10, 20, 30]
println(nums[1..]) // [10, 20, 30, 40]
```

在 V 中，切片就是数组本身，并不是两个截然不同的类型。因此，数组的操作在切片上都能执行。切片也能追加到相同类型元素的数组上：

```v
array_1 := [3, 5, 4, 7, 6]
mut array_2 := [0, 1]
array_2 << array_1[..3]
println(array_2) // `[0, 1, 3, 5, 4]`
```

切片总是以最小的容量 (`cap == len`) 来创建，无论源数组的容量和长度是多少。当向切片中增加元素导致切片容量变化，会立刻重新分配内存，此时切片将独立于源数组，不会改变源数组：

```v
mut a := [0, 1, 2, 3, 4, 5]
mut b := a[2..4]
b[0] = 7 // `b[0]` 是引用自 `a[2]`
println(a) // `[0, 1, 7, 3, 4, 5]`
b << 9
// `b` 会重新分配内存，此时就独立于 `a`
println(a) // `[0, 1, 7, 3, 4, 5]` - 不会改变
println(b) // `[7, 3, 9]`
```

向源数组中添加元素，如果超出容量的话，内存会重新分配，导致源数组会独立于子切片：

```v
mut a := []int{len: 5, cap: 6, init: 2}
mut b := a[1..4]
a << 3
// 没有超出 `cap` 不会重分配
b[2] = 13 // `a[3]` 是被修改的
a << 4
// a 会被重分配此时独立于 `b` (`cap` 扩展了)
b[1] = 3 // `a` 中不会变化
println(a) // `[2, 2, 2, 13, 2, 3, 4]`
println(b) // `[2, 3, 13]`
```

## 固定大小的数组

V 也同样支持固定大小的数组，不同于常规数组，其长度时固定的，不能添加删除元素，但是可以修改元素。

固定大小数组比常规数组更加高效，节省内存。它们的数据是存放在栈上，所以可以当缓存一样使用，避免在堆上进行额外的开销。

大多数方法只适用于常规数组，不适用于固定大小数组。可以将固定大小数组转换成数组切面使用。

```v
mut fnums := [3]int{} // fnums 是固定大小 3 的数组
fnums[0] = 1
fnums[1] = 10
fnums[2] = 100
println(fnums) // => [1, 10, 100]
println(typeof(fnums).name) // => [3]int

fnums2 := [1, 10, 100]! // 固定大小数组简短的声明方式（这个语法可能会改变）

anums := fnums[0..fnums.len]
println(anums) // => [1, 10, 100]
println(typeof(anums).name) // => []int
```

注意，切片的方式会导致复制固定大小数组的数据到一个新的常规数组中。

## Maps

```v
mut m := map[string]int{} // 键是 `string` 值是 `int` 的 map
m['one'] = 1
m['two'] = 2
println(m['one']) // "1"
println(m['bad_key']) // "0"
println('bad_key' in m) // `in` 可以检测是否有这个键存在
m.delete('two')
```

Maps 的键类型可以是 string, rune, integer, float 或 voidptr。

可以使用短声明的语法声明 map：

```v
numbers := map{
	'one': 1
	'two': 2
}
println(numbers)
```

如果找不到键，会返回零值：

```v
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
```

也可以使用 `or {}` 语法处理未找到键的情况：

```v
mm := map[string]int{}
val := mm['bad_key'] or { panic('key not found') }
```

同样也能在数组中使用 `or {}`：

```v
arr := [1, 2, 3]
large_index := 999
val := arr[large_index] or { panic('out of bounds') }
```

# 模块导入

关于创建模块的信息参见[模块](#模块)。

使用 `import` 关键字可以导入模块：

```v
import os

fn main() {
	// 从命令行中读取
	name := os.input('Enter your name: ')
	println('Hello, $name!')
}
```

上述代码引入了 os 模块就可以使用其公开的声明定义，就例如 input 函数。其它公共模块的公开声明参见 [标准库](https://modules.vlang.io/index.html)。

默认情况下，没事调用外部函数必须明确模块名，起初可能会显得很冗余，但是这样让代码更容易阅读和理解，能清楚的知道这个函数是从哪个模块中被调用的。对于大型程序而言是十分有用的。

和 Go 一样，不允许模块循环调用。

## 选择性导入

可以选择性导入特定的函数，直接在代码中使用：

```v
import os { input }

fn main() {
	// 从命令行中读取
	name := input('Enter your name: ')
	println('Hello, $name!')
}
```

注意：这还是会导入模块，而且对于常量而言是不可以这样使用。

可以一次同时导入多个函数：

```v
import os { input, user_os }

name := input('Enter your name: ')
println('Name: $name')
os := user_os()
println('Your OS is ${os}.')
```

## 模块导入别名

任何导入的模块可以使用 `as` 关键字声明别名，注意下面代码无法编译通过，除非创建 `mymod/sha256.v`：

```v
import crypto.sha256
import mymod.sha256 as mysha256

fn main() {
	v_hash := sha256.sum('hi'.bytes()).hex()
	my_hash := mysha256.sum('hi'.bytes()).hex()
	assert my_hash == v_hash
}
```

不能对导入的函数和类型建别名，但是可以重新声明一个类型。

```v
import time
import math

type MyTime = time.Time

fn (mut t MyTime) century() int {
	return int(1.0 + math.trunc(f64(t.year) * 0.009999794661191))
}

fn main() {
	mut my_time := MyTime{
		year: 2020
		month: 12
		day: 25
	}
	println(time.new_time(my_time).utc_string())
	println('Century: $my_time.century()')
}
```

# 条件语句和表达式

## If

```v
a := 10
b := 20
if a < b {
	println('$a < $b')
} else if a > b {
	println('$a > $b')
} else {
	println('$a == $b')
}
```

if 语句和其它语言类似，但是不同于类 C 语言，条件部分不需要小括号，而大括号是必须要有的。

if 语句可以用在表达式中：

```v
num := 777
s := if num % 2 == 0 { 'even' } else { 'odd' }
println(s)
// "odd"
```

### 类型检查

使用 `is` 可以检查当前类型，反之用 `!is`。可以使用在 if 语句中：

```v
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
```

也可以使用在 match 语句中：

```v
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
```

对结构体中字段也同样适用：

```v
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
```

对于可变变量这种检查是不安全的，然而，有时也是必要的。所以，需要在表达式中加入 `mnt` 关键字，来告诉编译器。像下面代码：

```v
mut x := MySumType(MyStruct{123})
if mut x is MyStruct {
	// x 即使是变量也会被识别为 MyStruct，没有 mut 就不会有效
	println(x)
}
// same with match
match mut x {
	MyStruct {
		// x 即使是变量也会被识别为 MyStruct，没有 mut 就不会有效
		println(x)
	}
}
```

## In 操作符

`in` 可以用来检查一个元素是否再数组或 map 中，反之用 `!in`。

```v
nums := [1, 2, 3]
println(1 in nums) // true
println(4 !in nums) // true
m := map{
	'one': 1
	'two': 2
}
println('one' in m) // true
println('three' !in m) // true
```

也可以使用在布尔表达式中使代码更简洁干净：

```v
enum Token {
	plus
	minus
	div
	mult
}

struct Parser {
	token Token
}

parser := Parser{}
if parser.token == .plus || parser.token == .minus || parser.token == .div || parser.token == .mult {
	// ...
}
if parser.token in [.plus, .minus, .div, .mult] {
	// ...
}
```

V 会优化上面的表达式，这两种方式都会生成相同的机器代码，不会有数组被创建。

## For 循环

V 只用一个循环关键字 for，有不同的用法。

### for / in

最常见的形式，可用在数组，map 和数值范围中。

#### 数组 for

```v
numbers := [1, 2, 3, 4, 5]
for num in numbers {
	println(num)
}
names := ['Sam', 'Peter']
for i, name in names {
	println('$i) $name')
	// Output: 0) Sam
	//         1) Peter
}
```

`for value in arr` 的形式可以遍历数组中每个元素，如果需要索引值，可以使用 `for index, value in arr`。

注意，这里的值是只读的，如果需要在循环过程中修改，需要声明可变变量：

```v
mut numbers := [0, 1, 2]
for mut num in numbers {
	num++
}
println(numbers) // [1, 2, 3]
```

当标识符是 `_` 下划线，则表示这个变量是忽略的。

#### 自定义遍历器

实现 `next` 函数的类型可以用在 for 循环中。

```v
struct SquareIterator {
	arr []int
mut:
	idx int
}

fn (mut iter SquareIterator) next() ?int {
	if iter.idx >= iter.arr.len {
		return error('')
	}
	defer {
		iter.idx++
	}
	return iter.arr[iter.idx] * iter.arr[iter.idx]
}

nums := [1, 2, 3, 4, 5]
iter := SquareIterator{
	arr: nums
}
for squared in iter {
	println(squared)
}

/*
打印：
1
4
9
16
25
*/
```

#### Map for

```v
m := map{
	'one': 1
	'two': 2
}
for key, value in m {
	println('$key -> $value')
	// Output: one -> 1
	//         two -> 2
}
```

键或值需要忽略的话，使用标识符 `_` 下划线即可。

```v
m := map{
	'one': 1
	'two': 2
}
// 只遍历 keys
for key, _ in m {
	println(key)
	// Output: one
	//         two
}
// 只遍历 values
for _, value in m {
	println(value)
	// Output: 1
	//         2
}
```

#### Range for

```v
// Prints '01234'
for i in 0 .. 5 {
	print(i)
}
```

`low .. high` 表示从 low 开始包含 low 到 high 结束但不包含 high 的区间 [lwo, high)。

### 条件 for 循环

```v
mut sum := 0
mut i := 0
for i <= 100 {
	sum += i
	i++
}
println(sum) // "5050"
```

类似于其它语言的 while，知道条件不满足时才停止、

### 无条件 for 循环

```v
mut num := 0
for {
	num += 2
	if num >= 10 {
		break
	}
}
println(num) // "10"
```

没有满足条件的无限循环。

### C for

```v
for i := 0; i < 10; i += 2 {
	// 不打印 6
	if i == 6 {
		continue
	}
	println(i)
}
```

最终是大家喜闻乐见的 C 风格 for 循环。这里的 i 不需要用 mut 修饰，因为默认会定义成可变值。

### 带标签的 break 和 continue

`break` 和`continue` 默认在 for 循环内部进行控制。可以带上标签跳转到外层循环中。

```v
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
```

标签必须紧跟在外部循环前，输出结果：

```v
4
5
6
7
```

## Match

```v
os := 'windows'
print('V is running on ')
match os {
	'darwin' { println('macOS.') }
	'linux' { println('Linux.') }
	else { println(os) }
}
```

match 语法是一个简单形式的 `if - else`。当一个分支满足时，会执行这个分支中的代码，没有分支满足时，会执行 else 中的代码。

```v
number := 2
s := match number {
	1 { 'one' }
	2 { 'two' }
	else { 'many' }
}
```

match 也可以用做表达式，返回最终符合的分支结果。

```v
enum Color {
	red
	blue
	green
}

fn is_red_or_blue(c Color) bool {
	return match c {
		.red, .blue { true } // 可用来匹配多值
		.green { false }
	}
}
```

match 对象是 enum 枚举时可以使用 `.variant_here` 短句语法，当每个枚举值列举时 else 是不能存在的。

```v
c := `v`
typ := match c {
	`0`...`9` { 'digit' }
	`A`...`Z` { 'uppercase' }
	`a`...`z` { 'lowercase' }
	else { 'other' }
}
println(typ) // 'lowercase'
```

可以使用范围匹配，在这个范围内则执行后面代码。

注意这里的范围是用 `...` 而不是 `..`，因为这个范围是包含最后一个值的，使用三点包含最后一个值，两点不包含最后一个值，在 match 使用两点会抛出错误。

## Defer

defer 包含的代码块只有在外层代码块执行结束返回时才执行。

```v
import os

fn read_log() {
	mut ok := false
	mut f := os.open('log.txt') or { panic(err.msg) }
	defer {
		f.close()
	}
	// ...
	if !ok {
		// defer 代码块会被调用，文件会被关闭
		return
	}
	// ...
	// defer 代码块会被调用，文件会被关闭
}
```

如果函数有返回值，defer 代码块会在返回表达式运行结束后再执行。

```v
import os

enum State {
	normal
	write_log
	return_error
}

// 写日志文件并返回写字节数量
fn write_log(s State) ?int {
	mut f := os.create('log.txt') ?
	defer {
		f.close()
	}
	if s == .write_log {
		// 在 `f.writeln()` 执行后，`f.close()` 才会被调用，写字节数会返回给 `main()`
		return f.writeln('This is a log file')
	} else if s == .return_error {
		//  在 `error()` 返回之后，文件会被关闭，但返回的错误信息中是打开的
		return error('nothing written; file open: $f.is_opened')
	}
	// 文件在这也会被关闭
	return 0
}

fn main() {
	n := write_log(.return_error) or {
		println('Error: $err')
		0
	}
	println('$n bytes written')
}
```

# 结构体 Struct

```v
struct Point {
	x int
	y int
}

mut p := Point{
	x: 10
	y: 20
}
println(p.x) // 结构体中字段通过点号使用 Struct fields are accessed using a dot
// 声明 3 个或更少字段的结构体的简短语法
p = Point{10, 20}
assert p.x == 10
```

## 堆上的结构体

结构体是分配在栈上的，如果要分配到堆上，并获得一个应用，使用 `&` 前缀：

```v
struct Point {
	x int
	y int
}

p := &Point{10, 10}
// 引用使用相同的方式获取字段
println(p.x)
```

p 的类型是 `&Point`，是 `Point` 的引用。应用类似于 Go 的指针和 C++ 的引用。

## 内嵌结构体

V 没有继承，但是支持内嵌结构体：

```v
struct Widget {
mut:
	x int
	y int
}

struct Button {
	Widget
	title string
}

mut button := Button{
	title: 'Click me'
}
button.x = 3
```

没有内嵌，则必须命名 Wiget 字段：

```v
button.widget.x = 3
```

## 默认字段值

```v
struct Foo {
	n   int    // n 默认是 0
	s   string // s 默认是 ''
	a   []int  // a 默认是 `[]int{}`
	pos int = -1 // 自定义默认值
}
```

结构体创建时所有字段都会分配默认零值，数组和 map 也会分配。也可以自定义默认值。

## 必须的字段

```v
struct Foo {
	n int [required]
}
```

可以标记结构体中某个字段 `[required]` 属性，那么在结构体创建时，这个字段必须显式的初始化。

## 尾部结构体字面语法

V 没有默认函数参数和命名参数，使用尾部结构体字面语法替代：

```v
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

fn new_button(c ButtonConfig) &Button {
	return &Button{
		width: c.width
		height: c.height
		text: c.text
	}
}

button := new_button(text: 'Click me', width: 100)
// height 没有设置，使用默认值
assert button.height == 20
```

new_button 函数原本传入 ButtonConfig 结构体，但是可以省略结构名和大括号，原本写法：

```v
new_button(ButtonConfig{text:'Click me', width:100})
```

这个只有当函数最后一个参数是结构体才有效。

## 访问修饰符

结构体字段默认是私有并不可变的。通过访问修饰符来改变，总共有 5 种形式：

```v
struct Foo {
	a int // 私有不可变（默认）
mut:
	b int // 私有可变
	c int // 可以列举多个在同一个修饰符下
pub:
	d int // 公开不可变（只读）
pub mut:
	e int // 公开但只有在父模块中可变
__global:
	// (不推荐使用，这也就是为什么在 'global' 前面加 __)
	f int // 随处公开可变
}
```

例如在 `builtin` 模块中的 `string` 类型：

```v
struct string {
    str &byte
pub:
    len int
}
```

其中 string 定义 str &byte 是私有不可变的，不能在 `builtin` 模块外访问，而 len 是公开不可变的：

```v
fn main() {
	str := 'hello'
	len := str.len // OK
	str.len++ // 编译错误
}
```

在 V 中定义只读公开字段是很容易的，无需定义获取方法。

## 方法

```v
struct User {
	age int
}

fn (u User) can_register() bool {
	return u.age > 16
}

user := User{
	age: 10
}
println(user.can_register()) // "false"
user2 := User{
	age: 20
}
println(user2.can_register()) // "true"
```

V 没有类，但是可以在类型上定义方法。方法是具有特殊接收器参数的函数，接收器出现在 fn 关键字和方法名称之间，有它自己的参数列表， 方法必须与接收器类型在同一模块中。

在上述例子中，`can_register` 方法的接收器是类型 User 的变量 u。这里习惯上不使用 self 和 this，而是一个简短的最好单字母长度的名字。

# 共用体 Unions

和结构体一样，共用体支持内嵌：

```v
struct Rgba32_Component {
	r byte
	g byte
	b byte
	a byte
}

union Rgba32 {
	Rgba32_Component
	value u32
}

clr1 := Rgba32{
	value: 0x008811FF
}

clr2 := Rgba32{
	Rgba32_Component: {
		a: 128
	}
}

sz := sizeof(Rgba32)
unsafe {
	println('Size: ${sz}B, clr1.b: $clr1.b, clr2.b: $clr2.b')
    // Size: 4B, clr1.b: 136, clr2.b: 0
}
```

共用体成员必须在 `unsafe` 块中访问。

注意：嵌套结构体参数不一定是按罗列顺序存储的。

# 函数 2

## 默认为纯函数

V 函数默认是纯函数，这意味着返回值只是函数的参数，并且对其计算没有副作用（除了 I/O）。

这是由于没有全局变量和所有函数默认不可变参数导致的，即使传递的是引用也一样。

然而 V 不是纯函数的语言，在编译选项中可以设置开启全局变量（`-enable-globals`），但是这个选项是为底层应用如内核、驱动所设计的。

## 可变参数

使用 mut 关键字可以是函数参数可变：

```v
truct User {
	name string
mut:
	is_registered bool
}

fn (mut u User) register() {
	u.is_registered = true
}

mut user := User{}
println(user.is_registered) // "false"
user.register()
println(user.is_registered) // "true"
```

上述代码中，接收器被定义成可变，则 `regiter()` 函数可以改变其值。同样也适用于非接收器的参数：

```v
fn multiply_by_2(mut arr []int) {
	for i in 0 .. arr.len {
		arr[i] *= 2
	}
}

mut nums := [1, 2, 3]
multiply_by_2(mut nums)
println(nums)
// "[2, 4, 6]"
```

注意在调用函数是必须在 nums 前添加 mut，明确函数调用会修改其值。

更推荐使用返回值的方式替代参数修改，参数修改只应该在性能要求较高的场景使用，减少内存分配和数据复制。

因此，V 不允许对原始变量进行参数修改，只有复杂类型，如数组，map 这种可以修改。

使用 `user.register()` 或 `user = register(user)` 替代 `register(mut user)`。

## 结构更新语法

V 提供简洁的方式返回更新结构：

```v
struct User {
	name          string
	age           int
	is_registered bool
}

fn register(u User) User {
	return User{
		...u
		is_registered: true
	}
}

mut user := User{
	name: 'abc'
	age: 23
}
user = register(user)
println(user)
```

## 可变数量参数

```v
n sum(a ...int) int {
	mut total := 0
	for x in a {
		total += x
	}
	return total
}

println(sum()) // 0
println(sum(1)) // 1
println(sum(2, 3)) // 5
a := [2, 3, 4]
println(sum(...a)) // 使用 ... 前缀进行数组分解，output: 9
b := [5, 6, 7]
println(sum(...b)) // output: 18
```

## 匿名和高阶函数

```v
fn sqr(n int) int {
	return n * n
}

fn cube(n int) int {
	return n * n * n
}

fn run(value int, op fn (int) int) int {
	return op(value)
}

fn main() {
	// 函数可以作为参数传递给另一个函数
	println(run(5, sqr)) // "25"
	// 匿名函数可以声明在一个函数内
	double_fn := fn (n int) int {
		return n + n
	}
	println(run(5, double_fn)) // "10"
	// 函数可以传递给另一个函数时不声明名字
	res := run(5, fn (n int) int {
		return n + n
	})
	println(res) // "10"
	// 可以声明函数数组或 map
	fns := [sqr, cube]
	println(fns[0](10)) // "100"
	fns_map := map{
		'sqr':  sqr
		'cube': cube
	}
	println(fns_map['cube'](2)) // "8"
}
```

# 引用

```v
struct Foo {}

fn (foo Foo) bar_method() {
	// ...
}

fn bar_function(foo Foo) {
	// ...
}
```

如果函数参数是不可变的，V 可能通过值或引用的形式传递，这个由编译器决定。开发者无需关心，不需要去记住传动的结构体是值还是引用。如果需要确保传递的是引用，则加上 `&`：

```v
struct Foo {
	abc int
}

fn (foo &Foo) bar() {
	println(foo.abc)
}
```

foo 依旧是不可变的，即使使用引用，要可变的话，必须使用 `(mut foo Foo)`。

通常来讲，V 的引用类似于 Go 的指针和 C++ 的引用。一个泛型的树结构定义：

```v
struct Node<T> {
	val   T
	left  &Node<T>
	right &Node<T>
}
```

# 常量

```v
const (
	pi    = 3.14
	world = '世界'
)

println(pi)
println(world)
```

使用 `const` 定义常量，常量只能定义在模块级别（函数外）。常量值不能改变，也可以分开定义：

```v
const e = 2.71828
```

V 的常量比其它语言的常量更加灵活，可以赋值复杂类型：

```v
struct Color {
	r int
	g int
	b int
}

fn rgb(r int, g int, b int) Color {
	return Color{
		r: r
		g: g
		b: b
	}
}

const (
	numbers = [1, 2, 3]
	red     = Color{
		r: 255
		g: 0
		b: 0
	}
	// 会在编译的时候评估函数调用*
	blue = rgb(0, 0, 255)
)

println(numbers)
println(red)
println(blue)
```

\*目前函数的调用是在程序启动的时候。普通情况下全局变量是不允许的，所以这就十分有用。

使用 `pub const` 可以将常量公开：

```v
module mymodule

pub const golden_ratio = 1.61803

fn calc() {
	println(mymodule.golden_ratio)
}
```

pub 关键字只能在 const 关键字之前，不能用在 `const ( )` 中。

声明常量使用 `snake_case` 的形式，为了与本地变量区分，常量使用都要用模块名明确。例如：pi 常量，在 math 模块内外使用都是 `math.pi`。 除了 main 模块之外，main 模块中定义的常量无需加 `main.`。

vfmt 也就自动识别，在模块内使用常量不加模块名，执行 vfmt 之后，会自动加上模块名。

# 内建函数

有些函数像 `println` 是内建函数，有如下：

```v
fn print(s string) // 打印任何东西到标准输出
fn println(s string) // 打印任何东西到标准输出并换行

fn eprint(s string) // 打印任何东西到错误输出
fn eprintln(s string) // 打印任何东西到错误输出并换行

fn exit(code int) // 使用自定义值退出程序
fn panic(s string) // 打印一个消息和堆栈信息到错误输出，并以错误码1结束程序
fn print_backtrace() // 打印堆栈信息到错误输出
```

`println` 是一个简单但强大的内建函数，可以打印任何类型：strings, numbers, arrays, maps, structs。

```v
struct User {
	name string
	age  int
}

println(1) // "1"
println('hi') // "hi"
println([1, 2, 3]) // "[1, 2, 3]"
println(User{ name: 'Bob', age: 20 }) // "User{name:'Bob', age:20}"
```

# 打印自定义类型

自定义类型实现 `.str() string` 方法，能自定义输出内容：

```v
struct Color {
	r int
	g int
	b int
}

pub fn (c Color) str() string {
	return '{$c.r, $c.g, $c.b}'
}

red := Color{
	r: 255
	g: 0
	b: 0
}
println(red) // {255, 0, 0}
```

# 模块

在同一个根目录下的文件都属于同一个模块。简单的程序不用特别声明模块，默认为 main 模块。

V 是一门模块化的语言，鼓励创建可重复使用的模块，并且创建模块相当容易。只需创建一个模块名的目录，将 .v 文件放入其中即可：

```v
cd ~/code/modules
mkdir mymodule
vim mymodule/myfile.v
```

```v
// myfile.v
module mymodule

// 为了暴露函数，必须使用 `pub`
pub fn say_hi() {
	println('hello from mymodule!')
}
```

这样就可以在 main 中使用 `mymodule`：

```v
import mymodule

fn main() {
	mymodule.say_hi()
}
```

- 模块名最好简短，在 10 个字符以下
- 模块名使用 `snake_case` 形式
- 不允许模块循环调用
- 一个模块中可以有许多 .v 文件
- 可以在任何地方创建模块
- 所有模块都会被静态编译到一个可执行文件

## 初始化函数

如果想引入的模块能自动调用初始化代码，使用 `init` 函数：

```v
fn init() {
	// 初始化自动执行的代码
}
```

`init` 函数是不能公开的，因为是自动调用的。这个功能堆初始化 C 库十分有用。

## 管理模块包

用法：

```
v [选项] [参数]
```

选项：

```
   install           从 VPM 中安装一个模块
   remove            删除一个从 VPM 中安装的模块
   search            从 VPM 中搜索一个模块
   update            从 VPM 中更新一个已安装模块
   upgrade           更新所有过时的模块
   list              罗列所有已安装的模块
   outdated          罗列需要更新的已安装模块
```

VPM 是 V Package Manager V 的包管理器：https://vpm.vlang.io/

安装模块：

```sh
v install [module]
```

例如：

```sh
v install ui
```

删除模块:

```sh
v remove [module]
```

例如：

```sh
v remove ui
```

更新模块：

```sh
v update [module]
```

例如：

```sh
v update ui
```

更新所有模块：

```sh
v update
```

罗列所有已安装的模块：

```sh
v list
```

例如：

```sh
> v list
Installed modules:
  markdown
  ui
```

罗列需要更新的已安装模块：

```sh
v outdated
```

例如：

```sh
> v outdated
Modules are up to date.
```

## 发布模块包

1 在模块根目录下创建 `v.mod` 文件，如果使用 `v new mymodule` 或 `v init` 创建模块，则自动生成 `v.mod` 。

```sh
v new mymodule
Input your project description: My nice module.
Input your project version: (0.0.0) 0.0.1
Input your project license: (MIT)
Initialising ...
Complete!
```

`v.mod` 例子：

```v ignore
Module {
    name: 'mymodule'
    description: 'My nice module.'
    version: '0.0.1'
    license: 'MIT'
    dependencies: []
}
```

最小的文件结构：

```
v.mod
mymodule.v
```

2 在 `v.mod` 文件同目录下创建 git 仓

```sh
git init
git add .
git commit -m "INIT"
```

3 在 github 上创建一个公开仓。

4 关联 github 上的公开仓，并提交代码上去。

5 使用 github 账号在 VPM 上注册 https://vpm.vlang.io/new，添加你的模块。

6 最终模块的名字是 github 账号和模块名的拼接，例如：`mygithubname.mymodule`。

可选：给模块打标签（git tag），更方便搜索。

# 类型声明

## 接口

```v
struct Dog {
	breed string
}

struct Cat {
	breed string
}

fn (d Dog) speak() string {
	return 'woof'
}

fn (c Cat) speak() string {
	return 'meow'
}

// 不同于 Go 但类似于 TypeScript, V 的接口除了方法还可以定义字段
interface Speaker {
	breed string
	speak() string
}

dog := Dog{'Leonberger'}
cat := Cat{'Siamese'}

mut arr := []Speaker{}
arr << dog
arr << cat
for item in arr {
	println('a $item.breed says: $item.speak()')
}
```

一个类型实现一个接口，只要实现接口的方法和字段，无需特别声明这个实现关系，也就是没有 "implements" 关键字。

### 转换接口

使用动态转换符 `is` 可以测试一个接口底层实际类型是什么：

```v
interface Something {}

fn announce(s Something) {
	if s is Dog {
		println('a $s.breed dog') // `s` 自动转换为 `Dog`
	} else if s is Cat {
		println('a $s.breed cat')
	} else {
		println('something else')
	}
}
```

更多参见[动态转换](#动态转换)。

### 接口方法定义

接口也能实现方法，也就是一个接口可以实现另一个接口的方法。当一个结构体被包装成一个接口，两者都实现相同的接口方法。此时接口变量调用的是接口实现的方法：

```v
struct Cat {}

fn (c Cat) speak() string {
	return 'meow!'
}

interface Adoptable {}

fn (a Adoptable) speak() string {
	return 'adopt me!'
}

fn new_adoptable() Adoptable {
	return Cat{}
}

fn main() {
	cat := Cat{}
	assert cat.speak() == 'meow!'
	a := new_adoptable() // 此时 a 的类型是 Adoptable
	assert a.speak() == 'adopt me!'
	if a is Cat { // 此时 a 的类型转换成 Cat
		println(a.speak()) // meow!
	}
}
```

## 函数类型

使用类型别名来命名一个函数签名，例如：

```v
type Filter = fn (string) string
```

这样就和类型一样，函数可以使用函数类型作为参数：

```v
type Filter = fn (string) string

fn filter(s string, f Filter) string {
	return f(s)
}
```

函数声明时无需特别定义，只要签名相同就可以使用：

```v
fn uppercase(s string) string {
	return s.to_upper()
}

// `uppercase` 可以传入任何使用 Filter 的地方
```

也可以明确定义函数类型：

```v
my_filter := Filter(uppercase)
```

这个转换纯粹是为了方便检查，其实可以无需特别声明：

```v
my_filter := uppercase
```

可以传递一个赋值的函数变量作为参数：

```v
println(filter('Hello world', my_filter)) // 打印 `HELLO WORLD`
```

也可以直接传递函数无需声明本地变量：

```v
println(filter('Hello world', uppercase))
```

匿名函数也可以：

```v
println(filter('Hello world', fn (s string) string {
	return s.to_upper()
}))
```

完整[例子](demos/function/types.v)。

## 枚举

```v
enum Color {
	red
	green
	blue
}

mut color := Color.red
// V 知道 `color` 是 `Color` 枚举类型， 无需使用 `color = Color.green`
color = .green
println(color) // "green"
match color {
	.red { println('the color was red') }
	.green { println('the color was green') }
	.blue { println('the color was blue') }
}
```

在 match 中使用枚举要么完全列举，要么使用 else，确保有新枚举字段添加时，能完全覆盖到。

枚举字段不能使用保留关键字，如果使用前面需要加 @。

```v
enum Color {
	@none
	red
	green
	blue
}

color := Color.@none
println(color)
```

整数可以赋值到枚举字段中：

```v
enum Grocery {
	apple
	orange = 5
	pear
}

g1 := int(Grocery.apple)
g2 := int(Grocery.orange)
g3 := int(Grocery.pear)
println('Grocery IDs: $g1, $g2, $g3') // Grocery IDs: 0, 5, 6
```

枚举值不能进行计算操作，操作的话需要转换成整型。

## 联合类型

联合类型的实例可以表示多个类型中的一个。使用 type 关键字定义：

```v
struct Moon {}

struct Mars {}

struct Venus {}

type World = Mars | Moon | Venus

sum := World(Moon{})
assert sum.type_name() == 'Moon'
println(sum)
```

内建函数 `type_name` 返回当前表示的类型名字。

利用联合类型可以构建简洁有效的递归结构代码：

```v
// V 二叉树
struct Empty {}

struct Node {
	value f64
	left  Tree
	right Tree
}

type Tree = Empty | Node

// 节点值求和
fn sum(tree Tree) f64 {
	return match tree {
		Empty { 0 }
		Node { tree.value + sum(tree.left) + sum(tree.right) }
	}
}

fn main() {
	left := Node{0.2, Empty{}, Empty{}}
	right := Node{0.3, Empty{}, Node{0.4, Empty{}, Empty{}}}
	tree := Node{0.5, left, right}
	println(sum(tree)) // 0.2 + 0.3 + 0.4 + 0.5 = 1.4
}
```

枚举也可以定义方法，和结构体一样：

```v
enum Cycle {
	one
	two
	three
}

fn (c Cycle) next() Cycle {
	match c {
		.one {
			return .two
		}
		.two {
			return .three
		}
		.three {
			return .one
		}
	}
}

mut c := Cycle.one
for _ in 0 .. 10 {
	println(c)
	c = c.next()
}
```

输出：

```
one
two
three
one
two
three
one
two
three
one
```

### 动态转换

检查一个联合类型的实例是否持有特定类型，使用 `sum is Type`。转换为特定类型，使用 `sum as Type`：

```v
struct Moon {}

struct Mars {}

struct Venus {}

type World = Mars | Moon | Venus

fn (m Mars) dust_storm() bool {
	return true
}

fn main() {
	mut w := World(Moon{})
	assert w is Moon
	w = Mars{}
	// 使用 `as` 转换成 Mars 实例
	mars := w as Mars
	if mars.dust_storm() {
		println('bad weather!')
	}
}
```

as 转换时如果不是 Mars 类型实例，会产生 panic。所以更安全的方式是使用智能转换。

### 智能转换

```v
if w is Mars {
	assert typeof(w).name == 'Mars'
	if w.dust_storm() {
		println('bad weather!')
	}
}
```

在 if 中 w 的类型就是 Mars，这就是 _flow-sensitive typing_。如果 w 是可变变量，需要在 w 前添加 mut，告诉编译器：

```v
if mut w is Mars {
	assert typeof(w).name == 'Mars'
	if w.dust_storm() {
		println('bad weather!')
	}
}
```

否则 w 保持原来的类型不变。对于复杂表达式 user.name 同样适用。

### 匹配联合类型

使用 match 可以确定类型：

```v
struct Moon {}

struct Mars {}

struct Venus {}

type World = Mars | Moon | Venus

fn open_parachutes(n int) {
	println(n)
}

fn land(w World) {
	match w {
		Moon {}
		Mars {
			open_parachutes(3)
		}
		Venus {
			open_parachutes(1)
		}
	}
}
```

match 必须列举所有可能类型或者使用 else 分支：

```v
struct Moon {}
struct Mars {}
struct Venus {}

type World = Moon | Mars | Venus

fn (m Moon) moon_walk() {}
fn (m Mars) shiver() {}
fn (v Venus) sweat() {}

fn pass_time(w World) {
    match w {
        // w 在各个分之中会自动转换
        Moon { w.moon_walk() }
        Mars { w.shiver() }
        else {}
    }
}
```

## 类型别名

使用别名的方式定义一个新类型，例如：`type NewType = ExistingType`。

这是联合类型的一种特殊形式。

## 选项/结果类型和错误处理

选项类型使用 `?Type` 来声明：

```v
struct User {
	id   int
	name string
}

struct Repo {
	users []User
}

fn (r Repo) find_user_by_id(id int) ?User {
	for user in r.users {
		if user.id == id {
			// V 自动包装成选择类型
			return user
		}
	}
	return error('User $id not found')
}

fn main() {
	repo := Repo{
		users: [User{1, 'Andrew'}, User{2, 'Bob'}, User{10, 'Charles'}]
	}
	user := repo.find_user_by_id(10) or { // 选项类型必须使用 `or` 块处理
		return
	}
	println(user.id) // "10"
	println(user.name) // "Charles"
}
```

V 结合了选项和结果到同一个类型中，无需决定使用哪一个。

将一个函数升级为选项函数，只需在返回结果前中加 `?`，如果发生错误就返回错误类型。

如果不需要返回错误，则直接 `return none`，这比 `return error("")` 要高效。

这是 V 的主要错误处理机制，其仍是返回值，但是优势在于错误不能不被处理，而且处理的方式咩有那么繁琐。不同于其它语言，没有 `throw/try/catch`。

```v
user := repo.find_user_by_id(7) or {
	println(err) // "User 7 not found"
	return
}
```

### 处理选项

有 4 中处理选项的方式。

第一种，直接传递给上层：

```v
import net.http

fn f(url string) ?string {
	resp := http.get(url) ?
	return resp.text
}
```

因为 `http.get` 返回 `?http.Response`，f 中没有处理而是直接传递给调用 f 的函数，所有 f 函数返回值也要加上 `?`。如果错误传递到 main 函数仍然没有处理，会发生 panic。

上诉 f 函数本质上是：

```v
    resp := http.get(url) or { return err }
    return resp.text
```

第二种，提前中断执行：

```v
user := repo.find_user_by_id(7) or { return }
```

这里，你要么调用 `panic()` 或 `exit()`，结束整个程序。要么使用控制流表达式（`return`, `break`, `continue`, 等）结束当前代码块。注意，`break` 和`continue`只能用在 for 循环中。

V 不能强制分解选项（例如 Rust 中的 `unwarp()` 或 Swift 的 `!` ）。而是使用 `or { panic(err.msg) }` 替代。

第三种，在 or 块中提供默认值，如果发送错误，会将这个默认值赋予变量，这个默认值值必须和变量是相同类型。

```v
fn do_something(s string) ?string {
	if s == 'foo' {
		return 'foo'
	}
	return error('invalid string') // `return none` 也行
}

a := do_something('foo') or { 'default' } // a 会是 'foo'
b := do_something('bar') or { 'default' } // b 会是 'default'
println(a)
println(b)
```

第四种，使用 if 分解：

```v
import net.http

if resp := http.get('https://google.com') {
	println(resp.text) // resp 是 http.Response 而不是选项类型
} else {
	println(err)
}
```

上述代码中，resp 只能在 if 的第一个分支中，err 只能在 else 分支中。

# 泛型

```v
struct Repo<T> {
    db DB
}

struct User {
	id   int
	name string
}

struct Post {
	id   int
	user_id int
	title string
	body string
}

fn new_repo<T>(db DB) Repo<T> {
    return Repo<T>{db: db}
}

// 泛型函数，V 会为每个使用的类型生成函数
fn (r Repo<T>) find_by_id(id int) ?T {
    table_name := T.name // 在这个例子中获取类型的名字就是获取表名
    return r.db.query_one<T>('select * from $table_name where id = ?', id)
}

db := new_db()
users_repo := new_repo<User>(db) // 返回 Repo<User>
posts_repo := new_repo<Post>(db) // 返回 Repo<Post>
user := users_repo.find_by_id(1)? // find_by_id<User>
post := posts_repo.find_by_id(1)? // find_by_id<Post>
```

当前泛型函数定义必须声明它们的类型参数，但将来 V 将从运行时参数类型中的单字母类型名称推断泛型类型参数。这就是 `find_by_id` 可以省略 `<T>` 的原因，因为接收器参数 r 使用泛型类型 T。

另一个例子：

```v
fn compare<T>(a T, b T) int {
	if a < b {
		return -1
	}
	if a > b {
		return 1
	}
	return 0
}

// compare<int>
println(compare(1, 0)) // Outputs: 1
println(compare(1, 1)) //          0
println(compare(1, 2)) //         -1
// compare<string>
println(compare('1', '0')) // Outputs: 1
println(compare('1', '1')) //          0
println(compare('1', '2')) //         -1
// compare<f64>
println(compare(1.1, 1.0)) // Outputs: 1
println(compare(1.1, 1.1)) //          0
println(compare(1.1, 1.2)) //         -1
```

# 并发

## 开启并发任务

V 并发模式十分类似于 Go，运行 `foo()` 在并发的线程上，使用 `go foo()`：

```v
import math

fn p(a f64, b f64) { // 没有返回值的普通函数
	c := math.sqrt(a * a + b * b)
	println(c)
}

fn main() {
	go p(3, 4)
	// p 会在并发线程上运行
}
```

有时候有必要在主线程中等待并发线程结束，需要开启线程时赋值一个 handle，调用 `wait()` 方法等待：

```v
import math

fn p(a f64, b f64) { // 没有返回值的普通函数
	c := math.sqrt(a * a + b * b)
	println(c) // prints `5`
}

fn main() {
	h := go p(3, 4)
	// p 会在并发线程上运行
	h.wait()
	// 等待 p 结束
}
```

对于有返回值的函数，无需修改也能并发运行得到结果：

```v
import math { sqrt }

fn get_hypot(a f64, b f64) f64 { // 有返回值的普通函数
	c := sqrt(a * a + b * b)
	return c
}

fn main() {
	g := go get_hypot(54.06, 2.08) // 开启线程处理
	h1 := get_hypot(2.32, 16.74) // 做其它计算
	h2 := g.wait() // 等待运行结束得到返回值
	println('Results: $h1, $h2') // 打印 `Results: 16.9, 54.1`
}
```

如果有大量任务的话，可以使用线程数组管理。

```v
import time

fn task(id int, duration int) {
	println('task $id begin')
	time.sleep(duration * time.millisecond)
	println('task $id end')
}

fn main() {
	mut threads := []thread{}
	threads << go task(1, 500)
	threads << go task(2, 900)
	threads << go task(3, 100)
	threads.wait()
	println('done')
}

// Output:
// task 1 begin
// task 2 begin
// task 3 begin
// task 3 end
// task 1 end
// task 2 end
// done
```

另外如果线程返回类型相同的话，调用 wait 函数可以得到完整的结果。

```v
fn expensive_computing(i int) int {
	return i * i
}

fn main() {
	mut threads := []thread int{}
	for i in 1 .. 10 {
		threads << go expensive_computing(i)
	}
	// Join all tasks
	r := threads.wait()
	println('All jobs finished: $r')
}

// Output: All jobs finished: [1, 4, 9, 16, 25, 36, 49, 64, 81]
```

## 管道

管道是沟通两个协程的推荐方式。V 的管理和 Go 的基本一致。队列的形式，带缓冲和不带缓冲，通过 select 在多个管道中选择。

### 语法和用法

管道声明使用 chan 关键字，缓冲大小使用 cap 属性：

```v
ch := chan int{} // 没有缓冲，同步的
ch2 := chan f64{cap: 100} // 缓冲大小 100
```

管道不用声明 mut。缓冲区长度不是类型的一部分，而是单个管道的属性。管道可以像变量一样传递给协程：

```v
fn f(ch chan int) {
	// ...
}

fn main() {
	ch := chan int{}
	go f(ch)
	// ...
}
```

使用箭头操作符可以向管道中送入数据，也可以从管道中读取数据：

```v
// 设置缓冲则送入数据不会阻塞
ch := chan int{cap: 1}
ch2 := chan f64{cap: 1}
n := 5
// 从入
ch <- n
ch2 <- 7.3
mut y := f64(0.0)
m := <-ch // 读取到一个新变量中
y = <-ch2 // 读取到一个存在的变量中
```

管道关闭后则不能送入数据，如果送入会产生运行时错误。读取缓冲为空的关闭管道会立刻返回错误，这时可以使用 or 处理。

```v
ch := chan int{}
ch2 := chan f64{}
// ...
ch.close()
// ...
m := <-ch or {
    println('channel has been closed')
}

// 传递错误
y := <-ch2 ?
```

### 管道选择

select 语句可以同时监控多个管道，而不会明显增加 CPU 负载。类似于 match 语句包含多个分支：

```v
import time

fn main() {
	ch := chan f64{}
	ch2 := chan f64{}
	ch3 := chan f64{}
	mut b := 0.0
	c := 1.0
	// 向 ch ch2 中输入数据
	go fn (the_channel chan f64) {
		time.sleep(5 * time.millisecond)
		the_channel <- 1.0
	}(ch)
	go fn (the_channel chan f64) {
		time.sleep(1 * time.millisecond)
		the_channel <- 1.0
	}(ch2)
	go fn (the_channel chan f64) {
		_ := <-the_channel
	}(ch3)

	select {
		a := <-ch {
			eprintln('> a: $a')
		}
		b = <-ch2 {
			eprintln('> b: $b')
		}
		ch3 <- c {
			time.sleep(5 * time.millisecond)
			eprintln('> c: $c was send on channel ch3')
		}
		> 500 * time.millisecond {
			// 0.5s 超时，没有管道处理
			eprintln('> more than 0.5s passed without a channel being ready')
		}
	}
	eprintln('> done')
}
```

超时分支是可选的，如果没有，select 可能会一直等待下去。可以使用 else 分支，但是这个会立即执行如果没有管道可用的话。`else` 和 `> timeout` 是互斥的。

select 还可以用作返回布尔类型的表达式，如果所有管道关闭的话返回 false ：

```v
if select {
    ch <- a {
        // ...
    }
} {
    // 管道开通的
} else {
    // 管道关闭的
}
```

### 管道特殊功能

管道内建了属性和方法：

```v
struct Abc {
	x int
}

a := 2.13
ch := chan f64{}
res := ch.try_push(a) // 试着执行 `ch <- a`
println(res)
l := ch.len // 在队列中的数据数量
c := ch.cap // 队列最大长度
is_closed := ch.closed // 管道是否关闭
println(l)
println(c)
mut b := Abc{}
ch2 := chan Abc{}
res2 := ch2.try_pop(mut b) // 试着执行 `b = <-ch2`
```

`try_push/pop()` 方法会立即返回以下某个结果：`.success`, `.not_ready` 或 `.closed`。但是这些属性和方法在生产环境中不建议使用，因为属性和方法的算法往往会产生数据竞态。尤其是 `.len` 和 `.closed` 不能用于关键判断，推荐使用 or 分支、错误传递或 select 语句。

## 共享对象

协程的数据交换可以通过共享变量的方式。通过 shared 关键字声明变量，此时 struct 中隐含了一个锁，使用 rlock 进行只读锁，lock 进行读写锁。

```v
struct St {
mut:
	x int // 共享的数据
}

fn (shared b St) g() {
	lock b {
		// 读写 b.x
	}
}

fn main() {
	shared a := St{
		x: 10
	}
	go a.g()
	// ...
	rlock a {
		// 读 a.x
	}
}
```

共享变量必须是 structs, arrays 或 maps。

# 解析 JSON

```v
import json

struct Foo {
	x int
}

struct User {
	name string
	age  int
	// `skip` 属性跳过 JSON 解析
	foo Foo [skip]
	// 如果字段名不同于 JSON，需要特别声明
	last_name string [json: lastName]
}

data := '{ "name": "Frodo", "lastName": "Baggins", "age": 25 }'
user := json.decode(User, data) or {
	eprintln('Failed to decode json')
	return
}
println(user.name)
println(user.last_name)
println(user.age)
// 可以解析 JSON 数组
sfoos := '[{"x":123},{"x":456}]'
foos := json.decode([]Foo, sfoos) ?
println(foos[0].x)
println(foos[1].x)
```

因为 JSON 无处不在，V 直接支持。

`json.decode` 函数需要两个参数：一是 JSON 解析的类型，二是包含 JSON 数据的字符串。

V 会生成 JSON 编码和解析的代码，不是通过反射实现，因此性能更好。

# 测试

## 断言

```v
fn foo(mut v []int) {
	v[0] = 1
}

mut v := [20]
foo(mut v)
assert v[0] < 4
```

使用 assert 关键字来断言后面的表达式是否成立，如果表达式返回 false，则程序会停止，并将表达式两侧的值都打印到错误输出中。assert 多用于检测程序的错误，易于查找未预计产生的值，可以用于任何函数中。

## 测试文件

```v
// hello.v
module main

fn hello() string {
	return 'Hello world'
}

fn main() {
	println(hello())
}
```

```v
module main

// hello_test.v
fn test_hello() {
	assert hello() == 'Hello world'
}
```

执行 `v hello_test.v` 会运行 `test_hello()` 函数，检查 `hello()` 是否返回正确的结果。这个命令会执行 `hello_test.v` 中所有的测试函数。

- 测试函数必须放在以 `_test.v` 结尾的测试文件中
- 测试函数必须以 `test_` 开头，才能执行
- 普通函数和其它类型都能在测试文件中声明，并正常使用
- 有两种测试文件：外部的和内部的
- 内部的测试文件模块名与要测试的模块名一致，并且可以调用私有的函数和类型
- 外部的测试文件则需要 import 引入要测试的模块，只能调用公开的 API

上述例子中，`hello_test.v` 和 `hello.v` 都是 `main` 模块的，所以是内部测试文件。

在测试文件中可以定义特殊的测试函数：

- `testsuite_begin` 在运行所有测试函数前调用
- `testsuite_end` 在运行所有测试函数后调用

如果测试函数中有错误返回，任何错误传递都会使测试失败：

```v
import strconv

fn test_atoi() ? {
	assert strconv.atoi('1') ? == 1
	assert strconv.atoi('one') ? == 1 // 测试失败
}
```

## 运行测试

运行单个测试文件 `v foo_test.v`，运行这个模块的测试 `v test mymodule`，或者 `v test .` 这会运行当前文件夹包其子文件夹下所有测试文件。使用 `--stats` 可以各个测试单元的详细信息。

可以创建一个名为 `testdata` 的文件夹存放额外的特殊数据（包括 .v 源文件），紧邻 \_test.v 文件。V 的测试框架在运行测试时会忽略此类文件夹。想放置带有无效 V 源代码或其他测试（包括已知失败的测试）的 .v 文件时就很有用，这些测试由 parent \_test.v 文件以特定方式/选项运行。

V 编译器的路径可由 @EXE 获取，所有在一个测试文件中，可以直接运行另一个测试文件：

```v
import os

fn test_subtest() {
	res := os.execute('${@VEXE} other_test.v')
	assert res.exit_code == 1
	assert res.output.contains('other_test.v does not exist')
}
```

# 内存管理

V 在一开始会使用值类型和字符串缓存来避免不必要的内存开销，提倡一种简单不过度抽象的代码风格。

大多数对象内存（约 90% - 100%）都由 V 的自动释放引擎释放。编译器在编译时会自动插入必要的内存释放调用，仍有一小部分通过引用计数释放。

开发者不需要改变任何代码，依旧有效，像 Python，Go 或 Java，除了没有影响效率的垃圾回收器进行每个对象的追踪和回收。

## 控制

可以利用 V 的自动释放引擎，为自定义类型定义 free 函数：

```v
struct MyType {}

[unsafe]
fn (data &MyType) free() {
	// ...
}
```

如编译器使用 C 的 free 函数来释放 C 的数据类型，编译器会在自定义数据类型的变量生命周期结束时静态插入 free 函数调用。

开发者如果想要更多的底层控制，可以使用 `-manualfree` 关闭自动释放引擎，或者在想要手动控制的函数上加 `[manualfree]` 属性。

注意：自动释放引擎在 V 0.3 版本后才会自动生效，此前需要使用 -autofree 手动使用。如果不使用的话，V 程序会产生内存泄漏。

## 例子

```v
import strings

fn draw_text(s string, x int, y int) {
	// ...
}

fn draw_scene() {
	// ...
	name1 := 'abc'
	name2 := 'def ghi'
	draw_text('hello $name1', 10, 10)
	draw_text('hello $name2', 100, 10)
	draw_text(strings.repeat(`X`, 10000), 10, 50)
	// ...
}
```

这些字符串不会从 draw_text 函数中逃逸，所以会在函数调用结束后回收。

实际上，使用 `-prealloc` 的话，前两个调用不会产生内存分配，这个两个字符串很小，V 会使用预分配缓存存放。

```v
struct User {
	name string
}

fn test() []int {
	number := 7 // 栈中分配变量
	user := User{} // 栈中分配结构体
	numbers := [1, 2, 3] // 数字分配在堆上，在函数结束时被释放
	println(number)
	println(user)
	println(numbers)
	numbers2 := [4, 5, 6] // 数组会返回，因此不在这里释放
	return numbers2
}
```

## 堆栈

堆栈基本：

如其它编程语言类似，有两个地方用来存放数据：

- 栈，能够以几乎零开销的方式快速进行分配。栈的增减随着函数的调用深度变化，每个函数都有自己的栈调用空间，直到函数返回前都是有效的。没有释放的对象也是必要的，然而这个对象当函数返回是时就无效了。此外，栈空间是有限的，通常每个线程只有几 M。
- 堆，由操作系统管理的大内存区域（通常几 G）。堆对象的分配和释放委派给操作系统的特殊函数调用来实现。这就意味着这些对象在多个函数调用中仍然有效，但是相应的管理成本就比较高。

### V 默认的方式

出于性能考虑，V 尽可能将对象分配在栈上，但是明显必须的话，也会分配到堆上。

例如：

```v
struct MyStruct {
	n int
}

struct RefStruct {
	r &MyStruct
}

fn main() {
	q, w := f()
	println('q: $q.r.n, w: $w.n')
}

fn f() (RefStruct, &MyStruct) {
	a := MyStruct{
		n: 1
	}
	b := MyStruct{
		n: 2
	}
	c := MyStruct{
		n: 3
	}
	e := RefStruct{
		r: &b
	}
	x := a.n + c.n
	println('x: $x')
	return e, &c
}
```

因为 a 从来没有离开 f 函数，a 是分配在栈上的。然而 b 的引用是作为 c 的一部分返回，以及直接返回 c 的引用，因此，b 和 c 是分配在堆上的。

当一个对象的引用做为函数的参数传入，那边这个堆栈分配就变得不是那边清晰：

```v
struct MyStruct {
mut:
	n int
}

fn main() {
	mut q := MyStruct{
		n: 7
	}
	w := MyStruct{
		n: 13
	}
	x := q.f(&w) // `q` 和 `w` 的引用传入
	println('q: $q\nx: $x')
}

fn (mut a MyStruct) f(b &MyStruct) int {
	a.n += b.n
	x := a.n * b.n
	return x
}
```

这里 q.f(&w) 的调用，将引用作为参数传入。由于 a 是 mut 的，b 是引用，所以理论上，会在 main 函数逃逸。然而，它们的生命周期没有在 main 函数内。所以 q 和 w 会分配在栈上。

### 手动控制堆栈

在上一个例子中，V 编译器将 q，w 放在栈上，是因为在调用时能推断这些应用的值只是读取或修改，而不是传递到其它地方。可以理解为将 q，w 借给 f 函数。

但是 f 函数对引用自身做操作的话，事情就不一样了：

```v
struct RefStruct {
mut:
	r &MyStruct
}

[heap]
struct MyStruct {
	n int
}

fn main() {
	m := MyStruct{}
	mut r := RefStruct{
		r: &m
	}
	r.g()
	println('r: $r')
}

fn (mut r RefStruct) g() {
	s := MyStruct{
		n: 7
	}
	r.f(&s) // 引用 `s` 设置到 `r` 中会传递回 `main() `
}

fn (mut r RefStruct) f(s &MyStruct) {
	r.r = s // 如果没有 `[heap]` 会触发错误
}
```

这里的 f 函数做了一个错误的事情就是将 s 的引用传递给 r。因为 s 的生命周期在 g 函数中，将其引用给到 r，会导致 r 引用了一个栈上的数据，编译器会给以警告。这就使得在 g 函数中调用 r.f(&s)，只是借用 s 的引用是错误的。

处理这种困境的办法是在声明 struct MyStruct 的时候在其上设置 [heap] 属性。这会使得编译器在分配 MyStruct 的对象时都设置在堆中，这样即使 g 返回了 s 的引用依旧是有效的。编译器会考虑到 MyStruct 的对象都是分配到堆中，检查 f 函数时会允许 s 的引用赋值给 r.r。

在其他语言中会常看到这种模式：

```v
fn (mut a MyStruct) f() &MyStruct {
	// a 的业务逻辑
	return &a // 返回 a 的引用
}
```

这里 f 函数将 a 的引用既做为接收器又做为函数返回值，这里的目的是可以实现向这样：y = x.f().g() 的链式调用。然而这种方式的问题，会创建第二个 a 的引用，不仅仅是借用，这就使得 MyStruct 不得不声明 [heap] 属性。

在 V 中更好的方式是：

```v
struct MyStruct {
mut:
	n int
}

fn (mut a MyStruct) f() {
	// `a` 的业务逻辑
}

fn (mut a MyStruct) g() {
	// `a` 的其它业务逻辑
}

fn main() {
	x := MyStruct{} // 栈分配
	mut y := x
	y.f()
	y.g()
	// 替代 `mut y := x.f().g()
}
```

这样 [heap] 属性就可以避免，执行效率更好。

然而，如上文提到栈空间是很有限的，因此一些比较大的结构体更适合使用 [heap] 属性声明，将其分配在堆中，即使不是上述所要求的情况。

有另一种方式可以根据情况手动控制分配，虽然不推荐但还是展示在这里：

```v
struct MyStruct {
	n int
}

struct RefStruct {
mut:
	r &MyStruct
}

// 在 `g()` 调用之后覆盖栈空间
fn use_stack() {
	x := 7.5
	y := 3.25
	z := x + y
	println('$x $y $z')
}

fn main() {
	m := MyStruct{}
	mut r := RefStruct{
		r: &m
	}
	r.g()
	use_stack() // 覆盖栈空间
	println('r: $r')
}

fn (mut r RefStruct) g() {
	s := &MyStruct{ // `s` 显式引用堆对象
		n: 7
	}
	// 改变 `&MyStruct` -> `MyStruct`，`r.f(s)` -> `r.f(&s)`
	// 为了确定栈空间数据被重写
	r.f(s)
}

fn (mut r RefStruct) f(s &MyStruct) {
	r.r = unsafe { s } // 忽略编译器检查
}
```

unsafe 块会禁止编译器检查，使用 &MyStruct{...} 的声明方式，使得 s 即使没有使用 [heap] 属性也被分配到堆上。

最后一步编译器不是必须的，但是没有的话，引用中 r 会是非法的，指向的内存区域被 use_stack 函数重写了，程序会崩溃，或至少产生无法预料的输出。这就是为什么该方法是不安全的，应避免使用。

# ORM

（仍然在 alpha 阶段）

V 自身支持 ORM（对象关系映射），支持 SQLite，MySQL 和 Postgres，后续也会支持 MS SQL 和 Oracle。

V 的 ORM 有如下优势：

- 对所有 SQL 都采用统一的语法，迁移数据库时更加方便。
- 查询语句使用 V 语法构造，无需学习新的语法。
- 安全，所有查询语句自动检查，防止 SQL 注入。
- 编译时检查，避免在运行时才发现拼写错误。
- 简单易理解，无需手动解析查询结果，构造对象。

```v
import sqlite

struct Customer {
	// 目前结构体名就是表名
	id        int    [primary; sql: serial] // 自增 `id` 必须是第一个
	name      string [nonull]
	nr_orders int
	country   string [nonull]
}

db := sqlite.connect('customers.db') ?

// 创建表
// CREATE TABLE IF NOT EXISTS `Customer` (`id` INTEGER PRIMARY KEY, `name` TEXT NOT NULL, `nr_orders` INTEGER, `country` TEXT NOT NULL)
sql db {
	create table Customer
}

// select count(*) from Customer
nr_customers := sql db {
	select count from Customer
}
println('number of all customers: $nr_customers')
// V 语法可以用来构建查询语句
uk_customers := sql db {
	select from Customer where country == 'uk' && nr_orders > 0
}
println(uk_customers.len)
for customer in uk_customers {
	println('$customer.id - $customer.name')
}
// 添加 `limit 1` 只返回一个结果
customer := sql db {
	select from Customer where id == 1 limit 1
}
println('$customer.id - $customer.name')
// 插入一个新的 customer
new_customer := Customer{
	name: 'Bob'
	nr_orders: 10
}
sql db {
	insert new_customer into Customer
}
```

更多例子和文档参见：[vlib/orm](https://github.com/vlang/v/tree/master/vlib/orm)。

# 文档编写

文档编写方式和 Go 类似，十分简单。无需在代码之外单独写文档，vdoc 会从代码中的文档字符串生成文档。

每个函数、类型、常量的文档放置在声明之前：

```v
// clearall clears all bits in the array
fn clearall() {
}
```

内容必须已定义的名字开始。

有时一行文字不够表达，可以分成多行表示：

```v
// copy_all recursively copies all elements of the array by their value,
// if `dupes` is false all duplicate values are eliminated in the process.
fn copy_all(dupes bool) {
	// ...
}
```

为了便于理解，文档使用现在时语态。

一个模块的介绍必须放在第一个行，紧接着模块名。

生成文档使用 vdoc，例如：`v doc net.http`。

# 工具

## 代码格式化 v fmt

无需担心如何格式化代码或设置代码样式手则，使用 v fmt 即可：

```sh
v fmt file.v
```

推荐设置到编辑器中，每次保存时执行 v fmt -w。一次格式化消耗短（< 30ms）。建议在推送代码前都运行一下。

## 性能

V 能很好的支持对程序的性能测试：v -profile profile.txt run file.v，会生成一个 profile.txt 文件便于分析。

生成的 profile.txt 文件有 4 列：

a) 函数调用频次

b) 函数调用总共耗时（ms）

c) 函数调用平均耗时（ns）

d) 函数名

对第 3 列（每个函数平均调用时间）排序：sort -n -k3 profile.txt|tail

也可以使用 stopwatches 测试部分代码：

```v
import time

fn main() {
	sw := time.new_stopwatch()
	println('Hello world')
	println('Greeting the world took: ${sw.elapsed().nanoseconds()}ns')
}
```

# 进阶

## 运行时追踪表达式

使用 dump(expr) 可以追踪 V 表示式值的变化，例如 factorial.v：

```v
fn factorial(n u32) u32 {
	if dump(n <= 1) {
		return dump(1)
	}
	return dump(n * factorial(n - 1))
}

fn main() {
	println(factorial(5))
}
```

运行 v run factorial.v，得到：

```sh
[factorial.v:2] n <= 1: false
[factorial.v:2] n <= 1: false
[factorial.v:2] n <= 1: false
[factorial.v:2] n <= 1: false
[factorial.v:2] n <= 1: true
[factorial.v:3] 1: 1
[factorial.v:5] n * factorial(n - 1): 2
[factorial.v:5] n * factorial(n - 1): 6
[factorial.v:5] n * factorial(n - 1): 24
[factorial.v:5] n * factorial(n - 1): 120
120
```

注意 dump(expr) 会打印源文件位置，表示式本身和表示式值。

## 内存不安全代码

有时为了效率，会添加底层代码，这有可能产生内存破坏或安全漏洞，V 支持写底层代码，但不是默认的。

V 要求任何潜在的内存不安全操作都要明确标记，可以提示其他人如果发生错误的话，可能是内存安全错误。

产生内存不安全的例子有：

- 指针计算
- 指针索引
- 转换指针到一个不匹配的类型中
- 调用特定 C 函数： `free`，`strlen` 和 `strncmp`。

明确内存不安全操作需要使用 `unsafe` 块包含：

```v
// allocate 2 uninitialized bytes & return a reference to them
mut p := unsafe { malloc(2) }
p[0] = `h` // Error: pointer indexing is only allowed in `unsafe` blocks
unsafe {
    p[0] = `h` // OK
    p[1] = `i`
}
p++ // Error: pointer arithmetic is only allowed in `unsafe` blocks
unsafe {
    p++ // OK
}
assert *p == `i`
```

最好不要将内存安全的操作放在 unsafe 块中，这样是 unsafe 的使用尽量明确。通常任何代码都可以认为是内存安全的，编译器可以校验。

如果怀疑程序有内存安全问题，首先看 unsafe 块，是如何与周围的代码配合的。

注意：这还在开发中。

## 带引用字段的结构体

Structs with references require explicitly setting the initial value to a reference value unless the struct already defines its own initial value.

Zero-value references, or nil pointers, will **NOT** be supported in the future, for now data structures such as Linked Lists or Binary Trees that rely on reference fields that can use the value `0`, understanding that it is unsafe, and that it can cause a panic.

```v
struct Node {
	a &Node
	b &Node = 0 // Auto-initialized to nil, use with caution!
}

// Reference fields must be initialized unless an initial value is declared.
// Zero (0) is OK but use with caution, it's a nil pointer.
foo := Node{
	a: 0
}
bar := Node{
	a: &foo
}
baz := Node{
	a: 0
	b: 0
}
qux := Node{
	a: &foo
	b: &bar
}
println(baz)
println(qux)
```

## sizeof and \_\_offsetof

- `sizeof(Type)` gives the size of a type in bytes.
- `__offsetof(Struct, field_name)` gives the offset in bytes of a struct field.

```v
struct Foo {
	a int
	b int
}v

assert sizeof(Foo) == 8
assert __offsetof(Foo, a) == 0
assert __offsetof(Foo, b) == 4
```

## 从 V 中调用 C

```v
#flag -lsqlite3
#include "sqlite3.h"
// See also the example from https://www.sqlite.org/quickstart.html
struct C.sqlite3 {
}

struct C.sqlite3_stmt {
}

type FnSqlite3Callback = fn (voidptr, int, &&char, &&char) int

fn C.sqlite3_open(&char, &&C.sqlite3) int

fn C.sqlite3_close(&C.sqlite3) int

fn C.sqlite3_column_int(stmt &C.sqlite3_stmt, n int) int

// ... you can also just define the type of parameter and leave out the C. prefix
fn C.sqlite3_prepare_v2(&C.sqlite3, &char, int, &&C.sqlite3_stmt, &&char) int

fn C.sqlite3_step(&C.sqlite3_stmt)

fn C.sqlite3_finalize(&C.sqlite3_stmt)

fn C.sqlite3_exec(db &C.sqlite3, sql &char, cb FnSqlite3Callback, cb_arg voidptr, emsg &&char) int

fn C.sqlite3_free(voidptr)

fn my_callback(arg voidptr, howmany int, cvalues &&char, cnames &&char) int {
	unsafe {
		for i in 0 .. howmany {
			print('| ${cstring_to_vstring(cnames[i])}: ${cstring_to_vstring(cvalues[i]):20} ')
		}
	}
	println('|')
	return 0
}

fn main() {
	db := &C.sqlite3(0) // this means `sqlite3* db = 0`
	// passing a string literal to a C function call results in a C string, not a V string
	C.sqlite3_open(c'users.db', &db)
	// C.sqlite3_open(db_path.str, &db)
	query := 'select count(*) from users'
	stmt := &C.sqlite3_stmt(0)
	// NB: you can also use the `.str` field of a V string,
	// to get its C style zero terminated representation
	C.sqlite3_prepare_v2(db, &char(query.str), -1, &stmt, 0)
	C.sqlite3_step(stmt)
	nr_users := C.sqlite3_column_int(stmt, 0)
	C.sqlite3_finalize(stmt)
	println('There are $nr_users users in the database.')
	//
	error_msg := &char(0)
	query_all_users := 'select * from users'
	rc := C.sqlite3_exec(db, &char(query_all_users.str), my_callback, voidptr(7), &error_msg)
	if rc != C.SQLITE_OK {
		eprintln(unsafe { cstring_to_vstring(error_msg) })
		C.sqlite3_free(error_msg)
	}
	C.sqlite3_clos
```

## 从 C 中调用 V

Since V can compile to C, calling V code from C is very easy.

By default all V functions have the following naming scheme in C: `[module name]__[fn_name]`.

For example, `fn foo() {}` in module `bar` will result in `bar__foo()`.

To use a custom export name, use the `[export]` attribute:

```v
[export: 'my_custom_c_name']
fn foo() {
}
```

## 原子操作

V has no special support for atomics, yet, nevertheless it's possible to treat variables as atomics by calling C functions from V. The standard C11 atomic functions like `atomic_store()` are usually defined with the help of macros and C compiler magic to provide a kind of _overloaded C functions_. Since V does not support overloading functions by intention there are wrapper functions defined in C headers named `atomic.h` that are part of the V compiler infrastructure.

There are dedicated wrappers for all unsigned integer types and for pointers. (`byte` is not fully supported on Windows) – the function names include the type name as suffix. e.g. `C.atomic_load_ptr()` or `C.atomic_fetch_add_u64()`.

To use these functions the C header for the used OS has to be included and the functions that are intended to be used have to be declared. Example:

```v
$if windows {
	#include "@VEXEROOT/thirdparty/stdatomic/win/atomic.h"
} $else {
	#include "@VEXEROOT/thirdparty/stdatomic/nix/atomic.h"
}

// declare functions we want to use - V does not parse the C header
fn C.atomic_store_u32(&u32, u32)
fn C.atomic_load_u32(&u32) u32
fn C.atomic_compare_exchange_weak_u32(&u32, &u32, u32) bool
fn C.atomic_compare_exchange_strong_u32(&u32, &u32, u32) bool

const num_iterations = 10000000

// see section "Global Variables" below
__global (
	atom u32 // ordinary variable but used as atomic
)

fn change() int {
	mut races_won_by_change := 0
	for {
		mut cmp := u32(17) // addressable value to compare with and to store the found value
		// atomic version of `if atom == 17 { atom = 23 races_won_by_change++ } else { cmp = atom }`
		if C.atomic_compare_exchange_strong_u32(&atom, &cmp, 23) {
			races_won_by_change++
		} else {
			if cmp == 31 {
				break
			}
			cmp = 17 // re-assign because overwritten with value of atom
		}
	}
	return races_won_by_change
}

fn main() {
	C.atomic_store_u32(&atom, 17)
	t := go change()
	mut races_won_by_main := 0
	mut cmp17 := u32(17)
	mut cmp23 := u32(23)
	for i in 0 .. num_iterations {
		// atomic version of `if atom == 17 { atom = 23 races_won_by_main++ }`
		if C.atomic_compare_exchange_strong_u32(&atom, &cmp17, 23) {
			races_won_by_main++
		} else {
			cmp17 = 17
		}
		desir := if i == num_iterations - 1 { u32(31) } else { u32(17) }
		// atomic version of `for atom != 23 {} atom = desir`
		for !C.atomic_compare_exchange_weak_u32(&atom, &cmp23, desir) {
			cmp23 = 23
		}
	}
	races_won_by_change := t.wait()
	atom_new := C.atomic_load_u32(&atom)
	println('atom: $atom_new, #exchanges: ${races_won_by_main + races_won_by_change}')
	// prints `atom: 31, #exchanges: 10000000`)
	println('races won by\n- `main()`: $races_won_by_main\n- `change()`: $races_won_by_change')
}
```

In this example both `main()` and the spawned thread `change()` try to replace a value of `17` in the global `atom` with a value of `23`. The replacement in the opposite direction is done exactly 10000000 times. The last replacement will be with `31` which makes the spawned thread finish.

It is not predictable how many replacements occur in which thread, but the sum will always be 10000000. (With the non-atomic commands from the comments the value will be higher or the program will hang – dependent on the compiler optimization used.)

## 全局变量

## 调试

## 条件编译

## 代码热加载

```v
module main

import time

[live]
fn print_message() {
	println('Hello! Modify this message while the program is running.')
}

fn main() {
	for {
		print_message()
		time.sleep(500 * time.millisecond)
	}
}
```

使用 `v -live message.v` 编译，需要热加载的代码在定义前使用 [live] 属性。目前不支持类型的热加载。

更多例子，可以参见：[github.com/vlang/v/tree/master/examples/hot_code_reload](https://github.com/vlang/v/tree/master/examples/hot_reload)。

## 跨平台编译

跨平台编译只需：

```
v -os windows .
```

或

```
v -os linux .
```

现在不支持跨平台编译 macOS。

如果没有 C 依赖，需要安装 Clang，LLD linker，和下载 Windows 和 Linux 的库和头文件的压缩包，V 会提供链接。

## 跨平台的 V shell 脚本

V 可以用作 shell 脚本来写部署和编译脚本等。简单易写，并且跨平台，在类 Unix 平台上和 Windows 一样运行 V 脚本。

V 脚本后缀 `.vsh`，os 模块中所有函数都是公共的（例如使用 `mkdir()` 而不是 `os.mkdir()`）。

一个 `deploy.vsh` 的例子：

```v
#!/usr/bin/env -S v run
// The shebang above associates the file to V on Unix-like systems,
// so it can be run just by specifying the path to the file
// once it's made executable using `chmod +x`.

// Remove if build/ exits, ignore any errors if it doesn't
rmdir_all('build') or { }

// Create build/, never fails as build/ does not exist
mkdir('build') ?

// Move *.v files to build/
result := exec('mv *.v build/') ?
if result.exit_code != 0 {
	println(result.output)
}
// Similar to:
// files := ls('.') ?
// mut count := 0
// if files.len > 0 {
//     for file in files {
//         if file.ends_with('.v') {
//              mv(file, 'build/') or {
//                  println('err: $err')
//                  return
//              }
//         }
//         count++
//     }
// }
// if count == 0 {
//     println('No files')
// }
```

可以像普通 v 程序一样编译生成二进制文件再运行 `v deploy.vsh && ./deploy`，或者使用 v 命令直接运行 `v run deploy.vsh`。在类 Unix 系统中，当添加了可执行权限 `chmod +x`: `./deploy.vsh`，文件可以直接运行。

## 属性

V 使用属性来修改函数和结构体的行为，属性使用 [ ] 定义在函数、结构体、枚举前，只有如下属性声明：

```v
// 调用函数时会返回被弃用的警告
[deprecated]
fn old_function() {
}

// 可以自定义警告信息
[deprecated: 'use new_function() instead']
fn legacy_function() {}

// 内联函数
[inline]
fn inlined_function() {
}

// 不内联函数
[noinline]
fn function() {
}

// 这种函数不会返回到其调用者。
// 这种函数可以用在 or 块结尾, 如 exit/1 或 panic/1。
// 这种函数没有返回类型， 并已 for{} 结束，或者被其他 `[noreturn]` 函数调用。
[noreturn]
fn forever() {
	for {}
}

// 修饰的结构体必须分配在堆上，可以被用作引用(`&Window`)或用在其它引用内(`&OuterStruct{ Window{...} }`)。
// 可以看堆栈一节。
[heap]
struct Window {
}

// 如果设置的参数不对，V 不会编译这个函数和其调用。
// 使用标志：`v -d flag`
[if debug]
fn foo() {
}

fn bar() {
	foo() // 如果 `-d debug` 没有，不会被调用。
}

// 指针参数指向的内存不会被回收
[keep_args_alive]
fn C.my_external_function(voidptr, int, voidptr) int

// 调用函数的代码必须在 unsafe{} 块中。
// 注意 `risky_business()` 中的代码仍然会被检查，除非使用 unsafe{} 块包含。
// 当调用 `[unsafe]` 的函数时在特定不安全的操作前后，仍然可以检查，更符合 V 的安全策略。
[unsafe]
fn risky_business() {
	// 这里代码仍然会被检查
	unsafe {
		// 这里的代码不会被检查，如指针计算，访问联合字段，调用其它 [unsafe] 函数，等...
		// 通常最好是将 unsafe 块代码最小化。
	}
	// 这里代码仍然会被检查
}

// V 的自动释放引擎不会管理这个函数里面的内存，必须手动释放内存。
[manualfree]
fn custom_allocations() {
}

// 只用于与 C 的交互，告诉 V 接下来的结构体在 C 中定义为 `typedef struct`
[typedef]
struct C.Foo {
}

// 对 Win32 API 代码传递函数时设置
[windows_stdcall]
fn C.DefWindowProc(hwnd int, msg int, lparam int, wparam int)

// 只有在 Windows 中使用，
// 如果引入图形库（gg，ui），优先显示图形窗口不会创建命令行窗口，使得 println() 失效。
// 使用这个属性可以创建命令行窗口，只有定义在 main 函数之前有效。
[console]
fn main() {
}
```

## Goto

V 使用 goto 允许无条件调整到一个标签。标签名和 goto 语句要在同一个函数中。goto 可以跳转到外层或更外层代码块中，允许跳过变量初始化，或跳回已释放内存的代码块，因此要求使用 unsafe 代码块。

```v
if x {
	// ...
	if y {
		unsafe {
			goto my_label
		}
	}
	// ...
}
my_label:
```

应尽量避免使用 goto，跳出嵌套循环可以使用[带标签的 break 和 continue](#带标签的 break 和 continue)，没有任何内存风险。

# 附录

## 附录 1：关键字

V 有 41 个保留关键字（3 个字面值 none，true，false）：

```v
as
asm
assert
atomic
break
const
continue
defer
else
embed
enum
false
fn
for
go
goto
if
import
in
interface
is
lock
match
module
mut
none
or
pub
return
rlock
select
shared
sizeof
static
struct
true
type
typeof
union
unsafe
__offsetof
```

## 附录 2：操作符

下面操作符只适用于原始类型：

```v
+    sum                    integers, floats, strings
-    difference             integers, floats
*    product                integers, floats
/    quotient               integers, floats
%    remainder              integers

~    bitwise NOT            integers
&    bitwise AND            integers
|    bitwise OR             integers
^    bitwise XOR            integers

!    logical NOT            bools
&&   logical AND            bools
||   logical OR             bools
!=   logical XOR            bools

<<   left shift             integer << unsigned integer
>>   right shift            integer >> unsigned integer


Precedence    Operator
    5             *  /  %  <<  >>  &
    4             +  -  |  ^
    3             ==  !=  <  <=  >  >=
    2             &&
    1             ||


Assignment Operators
+=   -=   *=   /=   %=
&=   |=   ^=
>>=  <<=
```
