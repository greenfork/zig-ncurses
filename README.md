# Ncurses Zig wrapper

Zig bindings for the ncurses library v6.2, a library for writing terminal
user interfaces (TUI) and terminal based games.

In heavy development. Usable but incomplete.

## Quickstart

Requires to install system libraries ncurses, ncurses-dev.

1. Clone this repository and move to it
```
git clone <this repo>
cd <this repo>
```
2. Copy this program to `hello.zig`:
```zig
usingnamespace @import("lib.zig").ncurses;

pub fn main() !void {
    _ = try initscr();
    defer endwin() catch {};
    try printwzig("All your {s}\n", .{"codebase"});
    try addstrzig("are belong to us.");
    try refresh();
    _ = try getch();
}
```
3. Run it with `zig run -lc -lcurses hello.zig`.

See `examples/` directory for more advanced things.

## Compared to C

- All the names are saved as they are
- Functions whose first argument is `Window` or `Screen` are inside respective
  structs and can be called as `stdscr.wprintw(...)`.
- In some places like `getyx` we must pass pointers, not values in place of `y` and `x`.
- Functions don't return -1 on error, they return Zig error from union.
- Printing functions have same interface as Zig and always take a struct `.{}` as
  a second argument. For strings pass a pointer `string.ptr` instead of the string itself.

## Printing

Don't use ncurses functions for printing strings to the screen unless you have to.
Use Zig versions instead with `zig` suffix at the end such as:
```
printwzig
mvprintwzig
addstrzig
mvaddstrzig
wprintwzig
mvwprintwzig
waddstrzig
mvwaddstrzig
```

They use `[]const u8` types for strings and formatting functions support Zig
`print` format, for example `{d}` for numbers instead of `%d` C style printf.
They also presumably do less allocations.

`Window` also implements `Writer` Zig interface and you can access it with
`writer` function, for example `stdscr.writer()`.

## Ideas about this wrapper

- In C error checking is tedious and sometimes completely ignored. In this
  library almost every function can return an error. Zig makes it so trivial
  with `try`.
- There was an idea of also transforming all names to native Zig casing but
  the library looks too inconsistent and old, for example there are functions
  like `attron` and `attr_on`. If we convert `attr_on` to `attrOn`, someone's
  head can eventually explode having to keep in mind all 3 versions and
  converting between them.
- Since there are complications with functions, we can as well go all the way
  in, so even constants are in C style SHOUTING_CASE.
- The single deviation is the use of Zig struct, for example for `WINDOW`
  there's a `Window` struct which keeps all the functions with the first
  argument `self`, a thin wrapper around the C pointer.
- Implementing Zig interfaces is so cool, for example `Writer` interface on
  `Window` allows us to use parts of standard library with this struct.

## License

MIT.
