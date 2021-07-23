a := 10
b := 20
if a < b {
	println('$a < $b')
} else if a > b {
	println('$a > $b')
} else {
	println('$a == $b')
}

num := 777
s := if num % 2 == 0 { 'even' } else { 'odd' }
println(s)
// "odd"
