nums := [0, 10, 20, 30, 40]
println(nums[1..4]) // [10, 20, 30]
println(nums[..4]) // [0, 10, 20, 30]
println(nums[1..]) // [10, 20, 30, 40]

array_1 := [3, 5, 4, 7, 6]
mut array_2 := [0, 1]
array_2 << array_1[..3]
println(array_2) // `[0, 1, 3, 5, 4]`

mut a := [0, 1, 2, 3, 4, 5]
mut b := a[2..4]
b[0] = 7 // `b[0]` 是引用自 `a[2]`
println(a) // `[0, 1, 7, 3, 4, 5]`
b << 9
// `b` 会重新分配内存，此时就独立于 `a`
println(a) // `[0, 1, 7, 3, 4, 5]` - 不会改变
println(b) // `[7, 3, 9]`

mut c := []int{len: 5, cap: 6, init: 2}
mut d := c[1..4]
c << 3
// 没有超出 `cap` 不会重分配
d[2] = 13 // `a[3]` 是被修改的
c << 4
// c 会被重分配此时独立于 `d` (`cap` 扩展了)
d[1] = 3 // `c` 中不会变化
println(c) // `[2, 2, 2, 13, 2, 3, 4]`
println(d) // `[2, 3, 13]`