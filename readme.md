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

