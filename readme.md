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

# 基础知识

[01 基础](./01基础.md)

# 类型

[02 类型](./02类型.md)

# 控制

[03 控制](./03控制.md)

# 结构体

[04 结构体](./04结构体.md)

# 函数

[05 函数](./05函数.md)

# 模块

[06 模块](./06模块.md)

# 类型声明

[07 类型声明](./07类型声明.md)

# 并发

[08 并发](./08并发.md)

# 其它

[09 其它](./09其它.md)

# 进阶

[10 进阶](./10进阶.md)

# 附录

[11 附录](./11附录.md)
