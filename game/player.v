module game

import term

const jump_frames = 30 // Jump for X frames
const jump_height = 3 // Jump height
const bottom_height = 2 // Bottom line position
const player_x_pos = 2 // Player position
const player_char = `O` // Player drawable rune

struct Player {
pub mut:
	jump       bool
	jump_until i64
}

pub fn (p Player) str() string {
	return match p.jump {
		true { 'Jump until frame == ${p.jump_until}' }
		false { 'No jump' }
	}
}

pub fn Player.new() Player {
	return Player{
		jump:       false
		jump_until: 0
	}
}

pub fn (mut p Player) jump(frame i64) {
	if p.jump {
		return
	}

	term.clear()

	p.jump = true
	p.jump_until = frame + jump_frames
}

pub fn (mut p Player) tick(frame i64) {
	if p.jump {
		if p.jump_until == frame {
			p.jump = false
			term.clear()
		}
	}
}

pub fn (p Player) draw(height int) {
	y := match true {
		p.jump { height - jump_height - bottom_height }
		else { height - bottom_height }
	}

	term.set_cursor_position(x: player_x_pos, y: y)

	print(player_char)
}

pub fn (p Player) check_collision(e Enemy) bool {
	if player_x_pos == e.x {
		match e {
			Bird {
				if p.jump {
					return true
				}
			}
			Cactus {
				if !p.jump {
				}
			}
		}
	}

	return false
}
