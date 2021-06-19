const std = @import("std");
pub usingnamespace @import("ncurses.zig");

const WIN_BORDER = struct {
    ls: chtype,
    rs: chtype,
    ts: chtype,
    bs: chtype,
    tl: chtype,
    tr: chtype,
    bl: chtype,
    br: chtype,
};

const WIN = struct {
    startx: c_int,
    starty: c_int,
    height: c_int,
    width: c_int,
    border: WIN_BORDER,
};

pub fn main() anyerror!void {
    var win: WIN = undefined;
    var ch: c_int = undefined;

    _ = try initscr();
    defer endwin() catch {};
    try start_color();
    try cbreak();

    try stdscr.keypad(true);
    try noecho();
    try init_pair(1, COLOR_CYAN, COLOR_BLACK);

    try init_win_params(&win);
    try attron(COLOR_PAIR(1));
    try printw("Press F1 to exit", .{});
    try attroff(COLOR_PAIR(1));
    try print_win_params(&win);

    try refresh();

    try create_box(&win, true);
    ch = try getch();
    while (ch != KEY_F(1)) : (ch = try getch()) {
        switch (ch) {
            KEY_LEFT => {
                try create_box(&win, false);
                win.startx -= 1;
                try create_box(&win, true);
            },
            KEY_RIGHT => {
                try create_box(&win, false);
                win.startx += 1;
                try create_box(&win, true);
            },
            KEY_UP => {
                try create_box(&win, false);
                win.starty -= 1;
                try create_box(&win, true);
            },
            KEY_DOWN => {
                try create_box(&win, false);
                win.starty += 1;
                try create_box(&win, true);
            },
            else => {},
        }
    }
}

fn init_win_params(p_win: *WIN) !void {
    p_win.*.height = 3;
    p_win.*.width = 10;
    p_win.*.starty = @divTrunc(LINES - p_win.height, 2);
    p_win.*.startx = @divTrunc(COLS - p_win.width, 2);
    p_win.*.border.ls = '|';
    p_win.*.border.rs = '|';
    p_win.*.border.ts = '-';
    p_win.*.border.bs = '-';
    p_win.*.border.tl = '+';
    p_win.*.border.tr = '+';
    p_win.*.border.bl = '+';
    p_win.*.border.br = '+';
}

fn print_win_params(p_win: *WIN) !void {
    try mvprintw(25, 0, "%d %d %d %d", .{ p_win.startx, p_win.starty, p_win.width, p_win.height });
    try refresh();
}

fn create_box(p_win: *WIN, flag: bool) !void {
    var i: c_int = undefined;
    var j: c_int = undefined;
    var x: c_int = undefined;
    var y: c_int = undefined;
    var w: c_int = undefined;
    var h: c_int = undefined;

    x = p_win.startx;
    y = p_win.starty;
    w = p_win.width;
    h = p_win.height;

    if (flag) {
        try mvaddch(y, x, p_win.border.tl);
        try mvaddch(y, x + w, p_win.border.tr);
        // std.log.debug("{d} {d} {d}\n", .{ y + h, x, p_win.border.bl });
        // std.debug.print("{d} {d} {d}\n", .{ y + h, x, p_win.border.bl });
        try mvaddch(y + h, x, p_win.border.bl);
        try mvaddch(y + h, x + w, p_win.border.br);
        try mvhline(y, x + 1, p_win.border.ts, w - 1);
        try mvhline(y + h, x + 1, p_win.border.bs, w - 1);
        try mvvline(y + 1, x, p_win.border.ls, h - 1);
        try mvvline(y + 1, x + w, p_win.border.rs, h - 1);
    } else {
        j = y;
        while (j <= y + h) : (j += 1) {
            i = x;
            while (i <= x + w) : (i += 1) {
                try mvaddch(j, i, ' ');
            }
        }
    }
}
