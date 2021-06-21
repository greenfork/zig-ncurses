const std = @import("std");
usingnamespace @import("ncurses").ncurses;

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

    // All are same:
    try win.mvwprintw(y + 1, x, "%s", .{string.ptr});
    try win.mvwaddstr(y + 2, x, string);
    try mvaddstr(y + 3, x, string);
    try win.mvwaddstrzig(y + 4, x, string);
    try mvprintwzig(y + 5, x, "{s}", .{string});
    try win.mvwprintwzig(y + 6, x, "{s}", .{string});

    try refresh();
}
