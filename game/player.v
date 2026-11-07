module game

import time
import term.ui as tui
import term

struct Player {
pub mut:
	pos int
}

pub fn (mut pl Player) jump() {
	if pl.pos != 0 {
		return
	}

	pl.pos = 3

	spawn fn [mut pl] () {
		time.sleep(1 * time.second)
		pl.pos = 0
	}()
}

pub fn (pl Player) draw(ctx &tui.Context) {
	_w, h := term.get_terminal_size()
	ctx.draw_point(2, h - (3 + pl.pos))
}
