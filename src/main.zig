const std = @import("std");
pub usingnamespace @import("ncurses.zig");

pub fn main() anyerror!void {
    var row: c_int = undefined;
    var col: c_int = undefined;
    const str: [*:0]const u8 = "Just a string";

    _ = Window.initscr();
    defer Window.endwin() catch {};

    Window.default().getmaxyx(&row, &col);
    try mvprintw(@divTrunc(row, 2), @divTrunc(col - @intCast(c_int, std.mem.len(str)), 2), "%s", .{str});
    try mvprintw(row - 2, 0, "This screen has %d rows and %d columns\n", .{ row, col });
    try printw("Try resizing your program", .{});
    try addch('c');
    try mvaddch(10, 10, 'b');
    try echochar('d');
    Window.default().getyx(&row, &col);
    try mvprintw(15, 0, "Cursor %d rows and %d columns\n", .{ row, col });
    Window.default().getbegyx(&row, &col);
    try mvprintw(17, 0, "Beg %d rows and %d columns\n", .{ row, col });
    Window.default().getparyx(&row, &col);
    try mvprintw(19, 0, "Par %d rows and %d columns\n", .{ row, col });

    // try raw();
    // try keypad(Window.default(), true);
    // try noecho();
    // try printw("Type any character to set it in bold\n", .{});
    // const ch = try getch();
    // if (ch == @enumToInt(Key.f1)) {
    //     try printw("F1 key pressed", .{});
    // } else {
    //     try printw("The pressed key is ", .{});
    //     try attron(@enumToInt(Attribute.bold));
    //     try printw("%c", .{ch});
    //     try attroff(@enumToInt(Attribute.bold));
    // }

    try refresh();
    _ = try getch();
}
