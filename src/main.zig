const std = @import("std");
pub usingnamespace @import("ncurses.zig");

pub fn main() anyerror!void {
    _ = try initscr();
    if (!has_colors()) {
        try endwin();
        std.debug.print("Your terminal does not support color\n", .{});
        std.process.exit(1);
    }
    try start_color();
    try init_pair(1, COLOR_RED, COLOR_BLACK);
    try attron(COLOR_PAIR(1));
    try print_in_middle(stdscr, @divTrunc(LINES, 2), 0, 0, "Viola !!! In color ...");
    try attroff(COLOR_PAIR(1));
    _ = try getch();
    try endwin();
}

fn print_in_middle(win: Window, starty: c_int, startx: c_int, width: c_int, string: [:0]const u8) !void {
    var length: c_int = undefined;
    var x: c_int = undefined;
    var y: c_int = undefined;
    var temp: f32 = undefined;
    var width_tmp = width;

    try win.getyx(&y, &x);
    if (startx != 0) x = startx;
    if (starty != 0) y = starty;
    if (width_tmp == 0) width_tmp = 80;

    length = @intCast(c_int, string.len);
    temp = @intToFloat(f32, width_tmp - length) / 2;
    x = startx + @floatToInt(c_int, temp);
    try win.mvwprintw(y, x, "%s", .{string.ptr});
    try refresh();
}
