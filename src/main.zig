const std = @import("std");
const nc = @import("c.zig").ncurses;

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
    _ = nc.initscr();
    _ = nc.raw();
    _ = nc.keypad(nc.stdscr, true);
    _ = nc.noecho();
    _ = nc.printw("Type any character to set it in bold\n");
    const ch = nc.getch();
    if (ch == nc.KEY_F(1)) {
        _ = nc.printw("F1 key pressed");
    } else {
        _ = nc.printw("The pressed key is ");
        _ = nc.attron(@as(u32, 1 << 21));
        _ = nc.printw("%c", ch);
        _ = nc.attroff(@as(u32, 1 << 21));
    }
    _ = nc.refresh();
    _ = nc.getch();
    _ = nc.endwin();
}
