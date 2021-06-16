const std = @import("std");
const nc = @import("C.zig").ncurses;

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
    _ = nc.initscr();
    _ = nc.printw("Hello world!");
    _ = nc.refresh();
    _ = nc.getch();
    _ = nc.endwin();
}
