import time

fn main() {
	ch := chan f64{}
	ch2 := chan f64{}
	ch3 := chan f64{}
	mut b := 0.0
	c := 1.0
	go fn (the_channel chan f64) {
		time.sleep(5 * time.millisecond)
		the_channel <- 1.0
	}(ch)
	go fn (the_channel chan f64) {
		time.sleep(1 * time.millisecond)
		the_channel <- 1.0
	}(ch2)
	go fn (the_channel chan f64) {
		_ := <-the_channel
	}(ch3)
	select {
		a := <-ch {
			eprintln('> a: $a')
		}
		b = <-ch2 {
			eprintln('> b: $b')
		}
		ch3 <- c {
			time.sleep(5 * time.millisecond)
			eprintln('> c: $c was send on channel ch3')
		}
		> 500 * time.millisecond {
			eprintln('> more than 0.5s passed without a channel being ready')
		}
	}
	eprintln('> done')
}
