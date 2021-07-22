# vlang中文文档

翻译自：[vlang doc](https://github.com/vlang/v/blob/master/doc/docs.md)

# 介绍

V是一门静态编译型语言，设计用来构建可维护的软件 。与Go相似，同时设计时参考了Oberon，Rust，Swift，Kotlin，Python。V推崇以最小的抽象来写简单干净的代码。除了简单外，V也能给予开发者很大的能力，所有能用其它语言实现的都能用V实现。

# 安装

最主要的安装方式是从源码安装，既简单又十分快（几秒即可）。

## Linux, macOS, FreeBSD等

首先需要git，和C编译器，例如：tcc，gcc或clang，还有make：

```shell
git clone https://github.com/vlang/v
cd v
make
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

