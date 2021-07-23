import os

enum State {
	normal
	write_log
	return_error
}

// write log file and return number of bytes written
fn write_log(s State) ?int {
	mut f := os.create('log.txt') ?
	defer {
		f.close()
	}
	if s == .write_log {
		return f.writeln('This is a log file')
	} else if s == .return_error {
		return error('nothing written; file open: $f.is_opened')
	}
	return 0
}

fn main() {
	n := write_log(.return_error) or {
		println('Error: $err')
		0
	}
	println('$n bytes written')
}
