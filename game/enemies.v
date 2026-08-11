module game

import rand
import term

struct Cactus {
pub mut:
	x      int
	height int
}

fn Cactus.new(width int) Cactus {
	return Cactus{
		x:      width
		height: rand.element([1, 2, 3]) or { panic(err) }
	}
}

struct Bird {
pub mut:
	x     int
	y     int
	width int
}

fn Bird.new(width int) Bird {
	return Bird{
		x:     width
		y:     rand.element([3, 4]) or { panic(err) }
		width: rand.element([1, 2, 3]) or { panic(err) }
	}
}

type Enemy = Cactus | Bird

fn Enemy.new(width int) Enemy {
	return rand.element([Enemy(Cactus.new(width)), Enemy(Bird.new(width))]) or { panic(err) }
}

fn (mut e Enemy) step() {
	e.x--
}

fn (e Enemy) draw(term_height int) {
	height := term_height - 2

	match e {
		Cactus {
			term.set_cursor_position(x: e.x, y: height)
			for _ in 0 .. e.height {
				print('#')
				term.cursor_up(1)
			}
		}
		Bird {
			term.set_cursor_position(x: e.x, y: e.y)
			print('<')
			term.cursor_forward(1)
			for _ in 0 .. e.width - 1 {
				print('=')
				term.cursor_forward(1)
			}
		}
	}
}
