# Ncurses Zig wrapper v6.2



## Compared to C

- All the names are saved as they are
- Functions whose first argument is `Window` or `Screen` are inside respective
  structs and can be called as `stdscr.wprintw(...)`.
- In some places like `getyx` we must pass pointers, not values in place of `y` and `x`.
- Functions don't return -1 on error, they return Zig error from union.
- Printing functions have same interface as Zig and always take a struct `.{}` as
  a second argument. For strings pass a pointer `string.ptr` instead of the string itself.
