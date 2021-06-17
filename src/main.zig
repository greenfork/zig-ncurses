const std = @import("std");
pub usingnamespace @import("ncurses.zig");

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
    _ = Window.initscr();
    defer Window.endwin() catch {};
    try raw();
    try keypad(Window.default(), true);
    try noecho();
    try printw("Type any character to set it in bold\n", .{});
    const ch = try getch();
    if (ch == @enumToInt(Key.f1)) {
        try printw("F1 key pressed", .{});
    } else {
        try printw("The pressed key is ", .{});
        try attron(@enumToInt(Attribute.bold));
        try printw("%c", .{ch});
        try attroff(@enumToInt(Attribute.bold));
    }
    try refresh();
    _ = try getch();
}
