const std = @import("std");
pub usingnamespace @import("ncurses").ncurses;

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
    var highlight: isize = 1;
    var choice: isize = 0;
    var c: c_int = 0;
    var event: MEVENT = undefined;

    _ = try initscr();
    defer endwin() catch {};
    try noecho();
    try clear();
    try cbreak();
    _ = mousemask(ALL_MOUSE_EVENTS | REPORT_MOUSE_POSITION, null);

    startx = @divTrunc(80 - width, 2);
    starty = @divTrunc(24 - height, 2);

    try attron(A_REVERSE);
    try mvaddstrzig(23, 1, "Click on Exit to quit (Works best in a virtual console)");
    try refresh();
    try attroff(A_REVERSE);

    const menu_win = try newwin(height, width, starty, startx);
    try menu_win.keypad(true);
    try printMenu(menu_win, highlight);

    while (true) {
        c = try menu_win.wgetch();
        switch (c) {
            KEY_MOUSE => {
                try getmouse(&event);

                if (event.bstate & BUTTON1_CLICKED != 0) {
                    try reportChoice(event.x + 1, event.y + 1, &choice);
                    if (choice == -1) break;
                    if (choice == 0) continue;
                    try mvprintwzig(
                        22,
                        1,
                        "Choice made is : {d} String Chosen is \"{s:10}\"",
                        .{ choice, choices[@intCast(usize, choice - 1)] },
                    );
                    try refresh();
                }
                try printMenu(menu_win, choice);
            },
            else => {},
        }
    }
}

fn printMenu(menu_win: Window, highlight: isize) !void {
    var x: c_int = 2;
    var y: c_int = 2;
    try menu_win.box(0, 0);
    var i: usize = 0;
    while (i < choices.len) : (i += 1) {
        if (highlight == i + 1) {
            try menu_win.wattron(A_REVERSE);
            try menu_win.mvwprintwzig(y, x, "{s}", .{choices[i]});
            try menu_win.wattroff(A_REVERSE);
        } else {
            try menu_win.mvwprintwzig(y, x, "{s}", .{choices[i]});
        }
        y += 1;
    }
    try menu_win.wrefresh();
}

fn reportChoice(mousex: c_int, mousey: c_int, choice: *isize) !void {
    var i = startx + 2;
    var j = starty + 3;
    var ch: usize = 0;

    while (ch < choices.len) : (ch += 1) {
        if (mousey == j + choice.* and mousex >= i and mousex <= i + @intCast(c_int, choices[ch].len)) {
            if (ch == choices.len - 1) {
                choice.* = -1;
            } else {
                choice.* += 1;
            }
        }
    }
}
