module game

import term

const jump_frames = 30 // Jump for X frames
const jump_height = 3 // Jump height
const bottom_height = 2 // Bottom line position
const player_x_pos = 2 // Player position
const player_char = `O` // Player drawable rune (Давайте считать, что динозавр 
							  // объелся и теперь круглый, окей?)

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

	p.jump = true
	p.jump_until = frame + jump_frames
}

pub fn (mut p Player) tick(frame i64) {
	if p.jump {
		if p.jump_until == frame {
			p.jump = false
		}
	}
}

fn (p Player) get_y_pos(height int) int { 
	return match p.jump {
		true { height - jump_height - bottom_height}
		false { height - bottom_height }
	}
}

pub fn (p Player) draw(height int) {
	term.set_cursor_position(x: player_x_pos, y: p.get_y_pos(height))

	print(player_char)
}

pub fn (p Player) check_collision(e Enemy, height int) bool {
	if player_x_pos == e.x {
		match e {
			Bird {
				if height - e.y == p.get_y_pos(height) {
					return true
				}
			}
			Cactus {
				if !p.jump {
					return true
				}
			}
		}
	}

	return false
}
