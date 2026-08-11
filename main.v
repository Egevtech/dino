module main

import term
import time
import game

const target_frame_time = 16 * time.millisecond // ~60 FPS
const frames_per_clear = 100 // Clear all terminal every X frames

fn main() {
	term.clear()

	width, height := 100, 15

	term.set_cursor_position(x: 5, y: 1)

	mut frames := 0

	term.hide_cursor()

	gi := game.GameInstance.new()

	for {
		if frames++ > frames_per_clear {
			frames = 0
			term.clear()
			term.set_cursor_position(x: 0, y: 0)
		}

		sw := time.new_stopwatch()

		// bottom line
		for i in 0 .. width {
			term.set_cursor_position(x: i, y: height - 1)
			print('=')
		}

		// key annotation
		key := term.key_pressed(
			echo:     false
			blocking: false
		)

		match key {
			` ` {
				println('Jump!')
			}
			`q` {
				term.set_cursor_position(x: 0, y: height)
				break
			}
			else {}
		}

		work_time := sw.elapsed()

		diff := target_frame_time - work_time

		compensation := match true {
			diff < 0 { 0 }
			else { diff }
		}

		term.set_cursor_position(x: width / 2, y: height / 2)

		time.sleep(compensation)

		frame_time := sw.elapsed().milliseconds()

		term.set_cursor_position(x: 0, y: 0)

		term.erase_line_clear()
		println('Frame: ${frames}')

		term.erase_line_clear()
		println('Work time: ${work_time.milliseconds()}ms')

		term.erase_line_clear()
		println('Compensation: ${compensation / time.millisecond}ms')

		term.erase_line_clear()
		println('Frame time: ${frame_time}ms')

		term.erase_line_clear()
		println('FPS: ~${time.second / frame_time}')

		term.set_cursor_position(x: width / 2, y: height / 2)
	}
}
