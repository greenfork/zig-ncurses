const std = @import("std");
pub usingnamespace @import("ncurses.zig");

pub fn main() anyerror!void {
    var startx: c_int = undefined;
    var starty: c_int = undefined;
    var width: c_int = undefined;
    var height: c_int = undefined;

    _ = try initscr();
    defer endwin() catch {};

    try stdscr.keypad(true);
    height = 3;
    width = 10;
    starty = @divTrunc(LINES - height, 2);
    startx = @divTrunc(COLS - width, 2);
    try printw("Press F1 to exit", .{});
    try refresh();
    var my_win = try create_newwin(height, width, starty, startx);

    var ch = try getch();
    while (ch != KEY_F(1)) : (ch = try getch()) {
        switch (ch) {
            KEY_LEFT => {
                try destroy_win(my_win);
                startx -= 1;
                my_win = try create_newwin(height, width, starty, startx);
            },
            KEY_RIGHT => {
                try destroy_win(my_win);
                startx += 1;
                my_win = try create_newwin(height, width, starty, startx);
            },
            KEY_UP => {
                try destroy_win(my_win);
                starty -= 1;
                my_win = try create_newwin(height, width, starty, startx);
            },
            KEY_DOWN => {
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
    const local_win = try newwin(height, width, starty, startx);
    try local_win.box(0, 0);
    try local_win.wrefresh();
    return local_win;
}

fn destroy_win(local_win: Window) !void {
    try local_win.wborder(' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
    try local_win.wrefresh();
    try local_win.delwin();
}
