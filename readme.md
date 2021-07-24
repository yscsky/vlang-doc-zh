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

可选：给模块打标签，更方便搜索。

# 类型声明

## 接口

## 枚举

## 联合类型

## 类型别名

## 可选/结果类型和错误处理

# 泛型

# 并发

## 生成并发任务

## 管道

## 共享对象

# 解码 JSON

# 测试

# 内存管理

## 堆栈

# ORM

# 文档输出

# 工具

## 代码格式化

## 性能

# 进阶

# 附录

## 附录 1：关键字

V 有 41 个保留关键字：

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
