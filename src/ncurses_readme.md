# Ncurses Zig wrapper v6.2

## Deviations

- In some places like `getyx` we must pass pointers, not values in place of `y` and `x`.
- Global variables are accessbiel via `Window`, e.g. `stdscr` is now `Window.std()`.
- Functions don't return -1 on error, they return Zig error from union.
