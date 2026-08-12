# Dino

A simple console arcade game written in V where you control a dino and avoid cactuses and birds.

## Description

- The game runs in the terminal.
- Controls are simple: jump and quit.
- The score increases every second frame.
- Enemies appear randomly and move from right to left.
- On collision, the game ends and can be restarted.

## How to run

1. Install V: https://vlang.io
2. Clone project: 
```sh
git clone https://github.com/egevtech/dino
```
3. Change into the project folder:

```sh
cd dino
```

4. Run the game:

```sh
v run .
```

## Controls

- Space — jump.
- `q` — quit the game.
- After game over:
  - `r` — restart.
  - `q` — quit.

## Notes

- The game expects a terminal size of at least `100x15`.
- It uses the built-in `term` module for rendering and input.
- Run with `--debug` to enable debugging output.
- This README was written by Github Copilot with a small edit from me, and the rest was created without using AI.
