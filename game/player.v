module game

import term

const jump_frames = 500 // Jump for X frames
const jump_height = 3 // Jump height
const bottom_height = 3 // Bottom line position
const player_x_pos = 2 // Player position
const player_char = `O` // Player drawable rune

struct Player {
pub mut:
	jump       bool
	jump_until i64
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
	if p.jump && p.jump_until >= frame {
		p.jump = false
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
