pub const ncurses = @cImport({
    // @cDefine("NCURSES_NOMACROS", "1");
    @cInclude("ncurses.h");
});
