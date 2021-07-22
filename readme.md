# vlang中文文档

翻译自：[vlang doc](https://github.com/vlang/v/blob/master/doc/docs.md)

# 介绍

V是一门静态编译型语言，设计用来构建可维护的软件 。与Go相似，同时设计时参考了Oberon，Rust，Swift，Kotlin，Python。

V是一门十分简单的语言，花1小时看完整篇文档，也就基本掌握了V。如果熟悉Go，那就已经掌握了80%。

V推崇以最小的抽象来写简单干净的代码。除了简单外，V也能给予开发者很大的能力，所有能用其它语言实现的都能用V实现。

# 安装

最主要的安装方式是从源码安装，既简单又十分快（几秒即可）。

## Linux, macOS, FreeBSD等

首先需要git，和C编译器，例如：tcc，gcc或clang，还有make：

```shell
git clone https://github.com/vlang/v
cd v
make
# 创建链接
sudo ./v symlink
```

## Windows

首先需要git，和C编译器，例如：tcc，gcc或clang，还有msvc：

```shell
git clone https://github.com/vlang/v
cd v
make.bat -tcc
```

make.bat后面也可以传递其它参数：-gcc，-msvc，-clang，来使用其它C编译器。但-tcc更小，容易安装（V会自动下载预编译的二进制）。

推荐将v目录添加到环境变量中，这样可以执行`v.exe symlink`。

## Android

可以通过vab安装v图形应用到Android上，

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

将上述代码保存到`hello.v`，再运行`v run hello.v`：

```shell
v run hello.v
hello world
```

恭喜，成功运行了第一个V程序。

通过`v hello.v`编译`hello.v`，生成hello的二进制文件，直接运行`./hello`。更多v指令说明可通过`v help`查看。

上述代码中，通过`fn`声明了一个名为main的函数，返回类型定义在函数名之后，main函数没有返回任何东西，所以main函数没有定义返回类型。

和其它语言（例如C，Go和Rust）一样，main函数是整个程序的入口。

`println`是内建函数，用来打印内容到标准输出上，一般就是输出到命令行上。

在单文件的程序中，`fn main()`可以被省略，在写类似脚本的代码或学习代码时十分便利。因此，为了简洁，下面教程中会省略`fn main()`。

所以上述代码，可以省略成：

```v
println('hello world')
```

一样可以通过v run运行。

# 运行多个文件

在一个文件夹中有多个文件，其中1个包含main函数，其它是辅助函数，想要将这个几个文件编译成一个可执行文件，可以通过`v run .`，如果带参数：`v run . --yourparam some_other_stuff`。

上述命令首先会编译生成可执行文件，然后将--yourparam some_other_stuff作为命令行参数传递到程序中。

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

注意：任何编译参数要放在run之前，任何程序执行参数，放在源码之后，参数会原样传递给程序，v命令不会处理。

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

与Go和C一样，函数不能重载，这样简化能提高代码的可维护性和可读性。

函数可以在声明前就使用，例如add和sub代码在main之后，但是main中可以调用。这适用于V中的所有声明，并且不需要头文件或考虑文件和声明的顺序。 

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

函数默认是私有的不对外暴露，要使得其它模块可以使用，需要前置`pub`，对于常量和类型都一样。	

注意：`pub`只能用于被命名的模块，如何创建模块参见[模块](#模块)。

# 变量

```v
name := 'Bob'
age := 20
large_number := i64(9999999999)
println(name)
println(age)
println(large_number)
```

使用`:=`声明和初始化变量，这也是V中唯一的声明方式，这也说明变量都有初始值。



# 模块

