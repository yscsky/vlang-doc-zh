mut nums := [1, 2, 3]
println(nums.len) // "3"
println(nums.cap) // "3" 或更多
nums = [] // 数组现在是空的
println(nums.len) // "0"

arr := []int{len: 5, init: -1}
println(arr)
println(arr.len)
println(arr.cap)

users := []int{}
println(users)
println(users.len)
println(users.cap)
