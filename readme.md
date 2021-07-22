# vlang 中文文档

翻译自：[vlang doc](https://github.com/vlang/v/blob/master/doc/docs.md)

# 介绍

V 是一门静态编译型语言，设计用来构建可维护的软件 。与 Go 相似，同时设计时参考了 Oberon，Rust，Swift，Kotlin，Python。

V 是一门十分简单的语言，花 1 小时看完整篇文档，也就基本掌握了 V。如果熟悉 Go，那就已经掌握了 80%。

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

**可变变量**

```v
mut age := 20
println(age)
age = 21
println(age)
```

改变变量的值使用 `=`，在 V 中，变量默认是不可变的。如果要可改变，则在变量声明时加 `mut`。

可以将上面代码中第一行的 mut 去除编译试试。

**初始化 vs 赋值**

注意区分 `:=` 和  `=`， `:=` 是用来声明和初始化变量， `=` 是用来赋值。

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

**变量声明的错误**

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





## 默认为纯函数

# 模块
