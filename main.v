import term.ui as tui
import term

struct App {
mut:
	tui &tui.Context = unsafe { nil }

pub mut:
	score u64
}

fn event(e &tui.Event, _x voidptr) {
	if e.typ == .key_down {
		match e.code {
			.escape, .q {
				exit(0)
			}
			else {}
		}
	}
}

fn frame(x voidptr) {
	mut app := unsafe { &App(x) }
	app.tui.clear()
	app.tui.set_cursor_position(0, 0)

	app.score += 1
	app.tui.draw_text(0, 0, 'Score: ${app.score}')

	width, height := term.get_terminal_size()

	app.tui.set_bg_color(r: 255, g: 255, b: 255)

	app.tui.draw_line(0, height - 2, width - 1, height - 2)

	app.tui.reset()
	app.tui.flush()
}

fn main() {
	mut app := &App{}
	app.tui = tui.init(
		user_data:    app
		event_fn:     event
		frame_fn:     frame
		hide_cursor:  true
		frame_rate:   30
		window_title: 'dino'
	)

	app.tui.run()!
}
