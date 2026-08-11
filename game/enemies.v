module game

import rand
import term

pub struct Cactus {
pub mut:
	x      int
	height int
}

fn Cactus.new(width int) Cactus {
	return Cactus{
		x:      width
		height: rand.element([2, 2, 3]) or { panic(err) }
	}
}

pub struct Bird {
pub mut:
	x     int
	y     int
	width int
}

fn Bird.new(width int) Bird {
	return Bird{
		x:     width
		y:     rand.element([2, 2, 4, 5, 5]) or { panic(err) }
		width: rand.element([2, 3]) or { panic(err) }
	}
}

pub type Enemy = Cactus | Bird

pub fn Enemy.new(width int) Enemy {
	return rand.element([Enemy(Cactus.new(width)), Enemy(Cactus.new(width)), Enemy(Cactus.new(width)),
		Enemy(Bird.new(width))]) or { panic(err) }
}

pub fn (mut e Enemy) step(step_size int) {
	e.x -= step_size
}

pub fn (e Enemy) draw(term_height int) {
	height := term_height - 2

	match e {
		Cactus {
			term.set_cursor_position(x: e.x, y: height)
			for _ in 0 .. e.height {
				print('# ')
				term.cursor_back(2)
				term.cursor_up(1)
			}
		}
		Bird {
			term.set_cursor_position(x: e.x, y: term_height - e.y)
			print('< ')
			for _ in 0 .. e.width - 1 {
				print('= ')
			}
		}
	}
}

pub fn (e Enemy) get_pos() int {
	return e.x
}
