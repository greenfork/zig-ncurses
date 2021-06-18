const std = @import("std");
pub usingnamespace @import("ncurses.zig");

pub fn main() anyerror!void {
    var startx: c_int = undefined;
    var starty: c_int = undefined;
    var width: c_int = undefined;
    var height: c_int = undefined;

    _ = Window.initscr();
    defer Window.endwin() catch {};

    try keypad(Window.std(), true);
    height = 3;
    width = 10;
    starty = @divTrunc(Window.lines() - height, 2);
    startx = @divTrunc(Window.cols() - width, 2);
    try printw("Press F1 to exit", .{});
    try refresh();
    var my_win = try create_newwin(height, width, starty, startx);

    var ch = try getch();
    while (ch != @enumToInt(Key.f1)) : (ch = try getch()) {
        switch (ch) {
            @enumToInt(Key.left) => {
                try destroy_win(my_win);
                startx -= 1;
                my_win = try create_newwin(height, width, starty, startx);
            },
            @enumToInt(Key.right) => {
                try destroy_win(my_win);
                startx += 1;
                my_win = try create_newwin(height, width, starty, startx);
            },
            @enumToInt(Key.up) => {
                try destroy_win(my_win);
                starty -= 1;
                my_win = try create_newwin(height, width, starty, startx);
            },
            @enumToInt(Key.down) => {
                try destroy_win(my_win);
                starty += 1;
                my_win = try create_newwin(height, width, starty, startx);
            },
            else => {},
        }
    }

    try refresh();
    _ = try getch();
}

fn create_newwin(height: c_int, width: c_int, starty: c_int, startx: c_int) !Window {
    const local_win = try Window.newwin(height, width, starty, startx);
    try local_win.box(0, 0);
    try local_win.wrefresh();
    return local_win;
}

fn destroy_win(local_win: Window) !void {
    try local_win.wborder(' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
    try local_win.wrefresh();
    try local_win.delwin();
}
