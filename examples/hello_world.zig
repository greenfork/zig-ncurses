usingnamespace @import("ncurses").ncurses;

pub fn main() !void {
    _ = try initscr();
    defer endwin() catch {};
    try printwzig("All your {s}\n", .{"codebase"});
    try addstrzig("are belongs to us.");
    try refresh();
    _ = try getch();
}
