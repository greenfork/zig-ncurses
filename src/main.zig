const std = @import("std");
pub usingnamespace @import("ncurses.zig");

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
    _ = Window.initscr();
    defer Window.endwin() catch {};
    try Window.raw();
    try Window.default().keypad(true);
    try Window.noecho();
    try Window.printw("Type any character to set it in bold\n", .{});
    const ch = try Window.getch();
    if (ch == @enumToInt(Key.f1)) {
        try Window.printw("F1 key pressed", .{});
    } else {
        try Window.printw("The pressed key is ", .{});
        try Window.attron(@as(u32, 1 << 21));
        try Window.printw("%c", .{ch});
        try Window.attroff(@as(u32, 1 << 21));
    }
    try Window.refresh();
    _ = try Window.getch();
}
