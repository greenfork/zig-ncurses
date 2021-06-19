const std = @import("std");
pub usingnamespace @import("ncurses.zig");

const width: c_int = 30;
const height: c_int = 10;
var startx: c_int = 0;
var starty: c_int = 0;

const choices = [_][]const u8{
    "Choice 1",
    "Choice 2",
    "Choice 3",
    "Choice 4",
    "Exit",
};

pub fn main() anyerror!void {
    var highlight: usize = 1;
    var choice: usize = 0;
    var c: c_int = undefined;

    _ = try initscr();
    defer endwin() catch {};
    try clear();
    try noecho();
    try cbreak();
    startx = @divTrunc(80 - width, 2);
    starty = @divTrunc(24 - height, 2);

    const menuWin = try newwin(height, width, starty, startx);
    try menuWin.keypad(true);
    try mvaddstrzig(0, 0, "Use arrow keys to go up and down, Press enter to select a choice");
    try refresh();
    try printMenu(menuWin, highlight);

    while (true) {
        c = try menuWin.wgetch();
        switch (c) {
            KEY_UP => {
                if (highlight == 1) {
                    highlight = choices.len;
                } else {
                    highlight -= 1;
                }
            },
            KEY_DOWN => {
                if (highlight == choices.len) {
                    highlight = 1;
                } else {
                    highlight += 1;
                }
            },
            10 => {
                choice = highlight;
            },
            else => {
                const ch = if (c > 0xff) ' ' else @intCast(u8, c);
                try mvprintwzig(
                    24,
                    0,
                    "Charcter pressed is = {d:3} Hopefully it can be printed as '{c}'",
                    .{ c, ch },
                );
                try refresh();
            },
        }
        try printMenu(menuWin, highlight);
        if (choice != 0) break;
    }

    try mvprintwzig(
        23,
        0,
        "You chose choice {d} with choice string {s}\n",
        .{ choice, choices[choice - 1] },
    );
    try clrtoeol();
    try refresh();
    _ = try getch();
}

fn printMenu(menuWin: Window, highlight: usize) !void {
    var x: c_int = 2;
    var y: c_int = 2;
    try menuWin.box(0, 0);
    var i: usize = 0;
    while (i < choices.len) : (i += 1) {
        if (highlight == i + 1) {
            try menuWin.wattron(A_REVERSE);
            try menuWin.mvwprintwzig(y, x, "{s}", .{choices[i]});
            try menuWin.wattroff(A_REVERSE);
        } else {
            try menuWin.mvwprintwzig(y, x, "{s}", .{choices[i]});
        }
        y += 1;
    }
    try menuWin.wrefresh();
}
