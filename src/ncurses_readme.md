# Ncurses Zig wrapper v6.2



## Deviations from C

In short:
- All the names are saved as they are
- Functions manipulating on specific windows and screens are scoped inside
  `Window` and `Screen` structs, but the ones with standard values, e.g.
  `stdscr`, are not scoped. If the function has `w` in the name, it is in
  `Window`.

More details:
- In some places like `getyx` we must pass pointers, not values in place of `y` and `x`.
- Global variables are accessbiel via `Window`, e.g. `stdscr` is now `Window.std()`.
- Functions don't return -1 on error, they return Zig error from union.
- Printing functions have same interface as Zig and always take a struct `.{}` as
  a second argument.
- Initialization functions are namespaced, e.g. `Window.newwin`, not just `newwin`
