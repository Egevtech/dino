module main

import term
import time
import game

const target_frame_time = 16 * time.millisecond // ~60 FPS

const score_i = 1 // Add i to score
const score_k = 2 // every k frames

const enemy_speed = 2 // step() enemy every X frames
const enemy_step_size = 2 // enemy step size

fn main() {
	term.clear()

	width, height := 100, 15
	// TODO: Check if terminal size less than needed

	mut frames := u64(0)

	term.hide_cursor()

	mut gi := game.GameInstance.new()
	mut player := game.Player.new()
	mut enemy := game.Enemy.new(width)

	for {
		frames++
		sw := time.new_stopwatch()

		// Score

		if frames % score_k == 0 {
			gi.score += score_i
		}

		score_line := 'Score: ${gi.score}'
		term.set_cursor_position(x: width - score_line.len, y: 0)
		print(score_line)

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
				player.jump(frames)
			}
			`q` {
				term.set_cursor_position(x: 0, y: height)
				break
			}
			else {}
		}

		// Player logic

		player.tick(frames)
		player.draw(height)

		// Enemy logic
		if frames % enemy_speed == 0 {
			enemy.step(enemy_step_size)
		}

		enemy.draw(height)

		if enemy.get_pos() <= 0 {
			enemy = game.Enemy.new(width)
		}

		// Collision check

		if player.check_collision(enemy, height) {
			term.clear()
			game_over_str := 'Game over! Your score: ${gi.score}'
			term.set_cursor_position(x: (width / 2) - (game_over_str.len / 2), y: height / 2)
			print("${game_over_str}")
			term.cursor_down(1)
			instr_str := 'Press "r" to restart, or "q" to quit'
			term.set_cursor_position(x: (width / 2) - (instr_str.len / 2), y: (height / 2) + 1)
			print("${instr_str}")

			for {
				akey := term.key_pressed(echo: false, blocking: false)

				if akey == `q` { term.clear(); exit(0) }
				else if akey == `r` { gi = game.GameInstance.new(); break }
			}

			continue
		}

		// Other stuff
		work_time := sw.elapsed()

		diff := target_frame_time - work_time

		compensation := match true {
			diff < 0 { 0 }
			else { diff }
		}

		term.set_cursor_position(x: width / 2, y: height / 2)

		time.sleep(compensation)
		term.clear()

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

		term.erase_line_clear()
		println('Player: ${player}')

		term.set_cursor_position(x: width / 2, y: height / 2)
	}
}
