const std = @import("std");
pub usingnamespace @import("ncurses.zig");

pub fn main() anyerror!void {
    var row: c_int = undefined;
    var col: c_int = undefined;
    const str: [*:0]const u8 = "Enter a string: ";
    var buf: [80:0]u8 = undefined;
    var number: c_int = undefined;

    _ = Window.initscr();
    defer Window.endwin() catch {};

    try start_color();
    try init_pair(1, @enumToInt(Color.cyan), @enumToInt(Color.black));
    try printw("A Big string which i didn't care to type fully ", .{});
    try mvchgat(0, 0, -1, @enumToInt(Attribute.blink), 1, null);

    try refresh();
    _ = try getch();
}
