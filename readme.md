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

## For循环

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

`low .. high` 表示从 low 开始包含 low 到 high 结束但不包含 high的区间 [lwo, high)。

### 条件 for 循环



### 无条件 for 循环



### C for



### 带标签的 break 和 continue



## Match





## Defer













# 结构体 Struct

# 共用体 Unions

# 函数 2

## 默认为纯函数

# 模块
