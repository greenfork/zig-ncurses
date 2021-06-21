const std = @import("std");
const c = @import("c.zig");

//====================================================================
// Types
//====================================================================

pub const chtype = if (c._LP64 == 1) c_uint else u32;
pub const mmask_t = if (c._LP64 == 1) c_uint else u32;
pub const attr_t = chtype;
pub const wchar_t = c.wchar_t;

pub const cchar_t = extern struct {
    attr: attr_t,
    chars: [CCHARW_MAX]wchar_t,
};

pub const NcursesError = error{
    GenericError,
};

pub const MEVENT = extern struct {
    id: c_short,
    x: c_int,
    y: c_int,
    z: c_int,
    bstate: mmask_t,
};

//====================================================================
// Constants defined as macros in C
//====================================================================

// Macro NCURSES_BITS is too hard for Zig to parse right now.

pub const NCURSES_ATTR_SHIFT: u5 = 8;

pub fn NCURSES_BITS(mask: c_uint, shift: u5) c_uint {
    return @intCast(chtype, mask) << (shift + NCURSES_ATTR_SHIFT);
}

pub fn COLOR_PAIR(n: c_int) c_int {
    return @intCast(c_int, NCURSES_BITS(@intCast(c_uint, n), 0) & A_COLOR);
}

pub fn PAIR_NUMBER(a: c_int) c_int {
    return @intCast(c_int, (@intCast(c_ulong, a) & A_COLOR) >> NCURSES_ATTR_SHIFT);
}

pub fn NCURSES_MOUSE_MASK(b: u5, m: c_uint) mmask_t {
    return m << (b - 1) * 5;
}

// zig fmt: off
const Err = c.ERR; // -1
const Ok = c.OK;   // 0

pub const COLOR_BLACK = c.COLOR_BLACK;     // 0
pub const COLOR_RED = c.COLOR_RED;         // 1
pub const COLOR_GREEN = c.COLOR_GREEN;     // 2
pub const COLOR_YELLOW = c.COLOR_YELLOW;   // 3
pub const COLOR_BLUE = c.COLOR_BLUE;       // 4
pub const COLOR_MAGENTA = c.COLOR_MAGENTA; // 5
pub const COLOR_CYAN = c.COLOR_CYAN;       // 6
pub const COLOR_WHITE = c.COLOR_WHITE;     // 7

pub const ACS_ULCORNER = c.ACS_ULCORNER; // NCURSES_ACS('l') /* upper left corner */
pub const ACS_LLCORNER = c.ACS_LLCORNER; // NCURSES_ACS('m') /* lower left corner */
pub const ACS_URCORNER = c.ACS_URCORNER; // NCURSES_ACS('k') /* upper right corner */
pub const ACS_LRCORNER = c.ACS_LRCORNER; // NCURSES_ACS('j') /* lower right corner */
pub const ACS_LTEE = c.ACS_LTEE;         // NCURSES_ACS('t') /* tee pointing right */
pub const ACS_RTEE = c.ACS_RTEE;         // NCURSES_ACS('u') /* tee pointing left */
pub const ACS_BTEE = c.ACS_BTEE;         // NCURSES_ACS('v') /* tee pointing up */
pub const ACS_TTEE = c.ACS_TTEE;         // NCURSES_ACS('w') /* tee pointing down */
pub const ACS_HLINE = c.ACS_HLINE;       // NCURSES_ACS('q') /* horizontal line */
pub const ACS_VLINE = c.ACS_VLINE;       // NCURSES_ACS('x') /* vertical line */
pub const ACS_PLUS = c.ACS_PLUS;         // NCURSES_ACS('n') /* large plus or crossover */
pub const ACS_S1 = c.ACS_S1;             // NCURSES_ACS('o') /* scan line 1 */
pub const ACS_S9 = c.ACS_S9;             // NCURSES_ACS('s') /* scan line 9 */
pub const ACS_DIAMOND = c.ACS_DIAMOND;   // NCURSES_ACS('`') /* diamond */
pub const ACS_CKBOARD = c.ACS_CKBOARD;   // NCURSES_ACS('a') /* checker board (stipple) */
pub const ACS_DEGREE = c.ACS_DEGREE;     // NCURSES_ACS('f') /* degree symbol */
pub const ACS_PLMINUS = c.ACS_PLMINUS;   // NCURSES_ACS('g') /* plus/minus */
pub const ACS_BULLET = c.ACS_BULLET;     // NCURSES_ACS('~') /* bullet */
pub const ACS_LARROW = c.ACS_LARROW;     // NCURSES_ACS(',') /* arrow pointing left */
pub const ACS_RARROW = c.ACS_RARROW;     // NCURSES_ACS('+') /* arrow pointing right */
pub const ACS_DARROW = c.ACS_DARROW;     // NCURSES_ACS('.') /* arrow pointing down */
pub const ACS_UARROW = c.ACS_UARROW;     // NCURSES_ACS('-') /* arrow pointing up */
pub const ACS_BOARD = c.ACS_BOARD;       // NCURSES_ACS('h') /* board of squares */
pub const ACS_LANTERN = c.ACS_LANTERN;   // NCURSES_ACS('i') /* lantern symbol */
pub const ACS_BLOCK = c.ACS_BLOCK;       // NCURSES_ACS('0') /* solid square block */
pub const ACS_S3 = c.ACS_S3;             // NCURSES_ACS('p') /* scan line 3 */
pub const ACS_S7 = c.ACS_S7;             // NCURSES_ACS('r') /* scan line 7 */
pub const ACS_LEQUAL = c.ACS_LEQUAL;     // NCURSES_ACS('y') /* less/equal */
pub const ACS_GEQUAL = c.ACS_GEQUAL;     // NCURSES_ACS('z') /* greater/equal */
pub const ACS_PI = c.ACS_PI;             // NCURSES_ACS('{') /* Pi */
pub const ACS_NEQUAL = c.ACS_NEQUAL;     // NCURSES_ACS('|') /* not equal */
pub const ACS_STERLING = c.ACS_STERLING; // NCURSES_ACS('}') /* UK pound sign */
pub const ACS_BSSB = c.ACS_BSSB;         // ACS_ULCORNER
pub const ACS_SSBB = c.ACS_SSBB;         // ACS_LLCORNER
pub const ACS_BBSS = c.ACS_BBSS;         // ACS_URCORNER
pub const ACS_SBBS = c.ACS_SBBS;         // ACS_LRCORNER
pub const ACS_SBSS = c.ACS_SBSS;         // ACS_RTEE
pub const ACS_SSSB = c.ACS_SSSB;         // ACS_LTEE
pub const ACS_SSBS = c.ACS_SSBS;         // ACS_BTEE
pub const ACS_BSSS = c.ACS_BSSS;         // ACS_TTEE
pub const ACS_BSBS = c.ACS_BSBS;         // ACS_HLINE
pub const ACS_SBSB = c.ACS_SBSB;         // ACS_VLINE
pub const ACS_SSSS = c.ACS_SSSS;         // ACS_PLUS

pub const _SUBWIN = c._SUBWIN;       // 0x01 /* is this a sub-window? */
pub const _ENDLINE = c._ENDLINE;     // 0x02 /* is the window flush right? */
pub const _FULLWIN = c._FULLWIN;     // 0x04 /* is the window full-screen? */
pub const _SCROLLWIN = c._SCROLLWIN; // 0x08 /* bottom edge is at screen bottom? */
pub const _ISPAD = c._ISPAD;         // 0x10 /* is this window a pad? */
pub const _HASMOVED = c._HASMOVED;   // 0x20 /* has cursor moved since last refresh? */
pub const _WRAPPED = c._WRAPPED;     // 0x40 /* cursor was just wrappped */
pub const _NOCHANGE = c._NOCHANGE; // -1
pub const _NEWINDEX = c._NEWINDEX; // -1

pub const A_NORMAL    : attr_t = 0;
pub const A_ATTRIBUTES: attr_t = NCURSES_BITS(~@as(c_uint, 0), 0);
pub const A_CHARTEXT  : attr_t = NCURSES_BITS(1, 0) - 1;
pub const A_COLOR     : attr_t = NCURSES_BITS((@as(c_uint, 1) << 8) - 1, 0);
pub const A_STANDOUT  : attr_t = NCURSES_BITS(1, 8);
pub const A_UNDERLINE : attr_t = NCURSES_BITS(1, 9);
pub const A_REVERSE   : attr_t = NCURSES_BITS(1, 10);
pub const A_BLINK     : attr_t = NCURSES_BITS(1, 11);
pub const A_DIM       : attr_t = NCURSES_BITS(1, 12);
pub const A_BOLD      : attr_t = NCURSES_BITS(1, 13);
pub const A_ALTCHARSET: attr_t = NCURSES_BITS(1, 14);
pub const A_INVIS     : attr_t = NCURSES_BITS(1, 15);
pub const A_PROTECT   : attr_t = NCURSES_BITS(1, 16);
pub const A_HORIZONTAL: attr_t = NCURSES_BITS(1, 17);
pub const A_LEFT      : attr_t = NCURSES_BITS(1, 18);
pub const A_LOW       : attr_t = NCURSES_BITS(1, 19);
pub const A_RIGHT     : attr_t = NCURSES_BITS(1, 20);
pub const A_TOP       : attr_t = NCURSES_BITS(1, 21);
pub const A_VERTICAL  : attr_t = NCURSES_BITS(1, 22);
pub const A_ITALIC    : attr_t = NCURSES_BITS(1, 23);

pub const KEY_CODE_YES = c.KEY_CODE_YES;   // 0400  /* A wchar_t contains a key code */
pub const KEY_MIN = c.KEY_MIN;             // 0401  /* Minimum curses key */
pub const KEY_BREAK = c.KEY_BREAK;         // 0401  /* Break key (unreliable) */
pub const KEY_SRESET = c.KEY_SRESET;       // 0530  /* Soft (partial) reset (unreliable) */
pub const KEY_RESET = c.KEY_RESET;         // 0531  /* Reset or hard reset (unreliable) */
pub const KEY_DOWN = c.KEY_DOWN;           // 0402  /* down-arrow key */
pub const KEY_UP = c.KEY_UP;               // 0403  /* up-arrow key */
pub const KEY_LEFT = c.KEY_LEFT;           // 0404  /* left-arrow key */
pub const KEY_RIGHT = c.KEY_RIGHT;         // 0405  /* right-arrow key */
pub const KEY_HOME = c.KEY_HOME;           // 0406  /* home key */
pub const KEY_BACKSPACE = c.KEY_BACKSPACE; // 0407  /* backspace key */
pub const KEY_F0 = c.KEY_F0;               // 0410  /* Function keys.  Space for 64 */
pub const KEY_DL = c.KEY_DL;               // 0510  /* delete-line key */
pub const KEY_IL = c.KEY_IL;               // 0511  /* insert-line key */
pub const KEY_DC = c.KEY_DC;               // 0512  /* delete-character key */
pub const KEY_IC = c.KEY_IC;               // 0513  /* insert-character key */
pub const KEY_EIC = c.KEY_EIC;             // 0514  /* sent by rmir or smir in insert mode */
pub const KEY_CLEAR = c.KEY_CLEAR;         // 0515  /* clear-screen or erase key */
pub const KEY_EOS = c.KEY_EOS;             // 0516  /* clear-to-end-of-screen key */
pub const KEY_EOL = c.KEY_EOL;             // 0517  /* clear-to-end-of-line key */
pub const KEY_SF = c.KEY_SF;               // 0520  /* scroll-forward key */
pub const KEY_SR = c.KEY_SR;               // 0521  /* scroll-backward key */
pub const KEY_NPAGE = c.KEY_NPAGE;         // 0522  /* next-page key */
pub const KEY_PPAGE = c.KEY_PPAGE;         // 0523  /* previous-page key */
pub const KEY_STAB = c.KEY_STAB;           // 0524  /* set-tab key */
pub const KEY_CTAB = c.KEY_CTAB;           // 0525  /* clear-tab key */
pub const KEY_CATAB = c.KEY_CATAB;         // 0526  /* clear-all-tabs key */
pub const KEY_ENTER = c.KEY_ENTER;         // 0527  /* enter/send key */
pub const KEY_PRINT = c.KEY_PRINT;         // 0532  /* print key */
pub const KEY_LL = c.KEY_LL;               // 0533  /* lower-left key (home down) */
pub const KEY_A1 = c.KEY_A1;               // 0534  /* upper left of keypad */
pub const KEY_A3 = c.KEY_A3;               // 0535  /* upper right of keypad */
pub const KEY_B2 = c.KEY_B2;               // 0536  /* center of keypad */
pub const KEY_C1 = c.KEY_C1;               // 0537  /* lower left of keypad */
pub const KEY_C3 = c.KEY_C3;               // 0540  /* lower right of keypad */
pub const KEY_BTAB = c.KEY_BTAB;           // 0541  /* back-tab key */
pub const KEY_BEG = c.KEY_BEG;             // 0542  /* begin key */
pub const KEY_CANCEL = c.KEY_CANCEL;       // 0543  /* cancel key */
pub const KEY_CLOSE = c.KEY_CLOSE;         // 0544  /* close key */
pub const KEY_COMMAND = c.KEY_COMMAND;     // 0545  /* command key */
pub const KEY_COPY = c.KEY_COPY;           // 0546  /* copy key */
pub const KEY_CREATE = c.KEY_CREATE;       // 0547  /* create key */
pub const KEY_END = c.KEY_END;             // 0550  /* end key */
pub const KEY_EXIT = c.KEY_EXIT;           // 0551  /* exit key */
pub const KEY_FIND = c.KEY_FIND;           // 0552  /* find key */
pub const KEY_HELP = c.KEY_HELP;           // 0553  /* help key */
pub const KEY_MARK = c.KEY_MARK;           // 0554  /* mark key */
pub const KEY_MESSAGE = c.KEY_MESSAGE;     // 0555  /* message key */
pub const KEY_MOVE = c.KEY_MOVE;           // 0556  /* move key */
pub const KEY_NEXT = c.KEY_NEXT;           // 0557  /* next key */
pub const KEY_OPEN = c.KEY_OPEN;           // 0560  /* open key */
pub const KEY_OPTIONS = c.KEY_OPTIONS;     // 0561  /* options key */
pub const KEY_PREVIOUS = c.KEY_PREVIOUS;   // 0562  /* previous key */
pub const KEY_REDO = c.KEY_REDO;           // 0563  /* redo key */
pub const KEY_REFERENCE = c.KEY_REFERENCE; // 0564  /* reference key */
pub const KEY_REFRESH = c.KEY_REFRESH;     // 0565  /* refresh key */
pub const KEY_REPLACE = c.KEY_REPLACE;     // 0566  /* replace key */
pub const KEY_RESTART = c.KEY_RESTART;     // 0567  /* restart key */
pub const KEY_RESUME = c.KEY_RESUME;       // 0570  /* resume key */
pub const KEY_SAVE = c.KEY_SAVE;           // 0571  /* save key */
pub const KEY_SBEG = c.KEY_SBEG;           // 0572  /* shifted begin key */
pub const KEY_SCANCEL = c.KEY_SCANCEL;     // 0573  /* shifted cancel key */
pub const KEY_SCOMMAND = c.KEY_SCOMMAND;   // 0574  /* shifted command key */
pub const KEY_SCOPY = c.KEY_SCOPY;         // 0575  /* shifted copy key */
pub const KEY_SCREATE = c.KEY_SCREATE;     // 0576  /* shifted create key */
pub const KEY_SDC = c.KEY_SDC;             // 0577  /* shifted delete-character key */
pub const KEY_SDL = c.KEY_SDL;             // 0600  /* shifted delete-line key */
pub const KEY_SELECT = c.KEY_SELECT;       // 0601  /* select key */
pub const KEY_SEND = c.KEY_SEND;           // 0602  /* shifted end key */
pub const KEY_SEOL = c.KEY_SEOL;           // 0603  /* shifted clear-to-end-of-line key */
pub const KEY_SEXIT = c.KEY_SEXIT;         // 0604  /* shifted exit key */
pub const KEY_SFIND = c.KEY_SFIND;         // 0605  /* shifted find key */
pub const KEY_SHELP = c.KEY_SHELP;         // 0606  /* shifted help key */
pub const KEY_SHOME = c.KEY_SHOME;         // 0607  /* shifted home key */
pub const KEY_SIC = c.KEY_SIC;             // 0610  /* shifted insert-character key */
pub const KEY_SLEFT = c.KEY_SLEFT;         // 0611  /* shifted left-arrow key */
pub const KEY_SMESSAGE = c.KEY_SMESSAGE;   // 0612  /* shifted message key */
pub const KEY_SMOVE = c.KEY_SMOVE;         // 0613  /* shifted move key */
pub const KEY_SNEXT = c.KEY_SNEXT;         // 0614  /* shifted next key */
pub const KEY_SOPTIONS = c.KEY_SOPTIONS;   // 0615  /* shifted options key */
pub const KEY_SPREVIOUS = c.KEY_SPREVIOUS; // 0616  /* shifted previous key */
pub const KEY_SPRINT = c.KEY_SPRINT;       // 0617  /* shifted print key */
pub const KEY_SREDO = c.KEY_SREDO;         // 0620  /* shifted redo key */
pub const KEY_SREPLACE = c.KEY_SREPLACE;   // 0621  /* shifted replace key */
pub const KEY_SRIGHT = c.KEY_SRIGHT;       // 0622  /* shifted right-arrow key */
pub const KEY_SRSUME = c.KEY_SRSUME;       // 0623  /* shifted resume key */
pub const KEY_SSAVE = c.KEY_SSAVE;         // 0624  /* shifted save key */
pub const KEY_SSUSPEND = c.KEY_SSUSPEND;   // 0625  /* shifted suspend key */
pub const KEY_SUNDO = c.KEY_SUNDO;         // 0626  /* shifted undo key */
pub const KEY_SUSPEND = c.KEY_SUSPEND;     // 0627  /* suspend key */
pub const KEY_UNDO = c.KEY_UNDO;           // 0630  /* undo key */
pub const KEY_MOUSE = c.KEY_MOUSE;         // 0631  /* Mouse event has occurred */
pub const KEY_RESIZE = c.KEY_RESIZE;       // 0632  /* Terminal resize event */
pub const KEY_EVENT = c.KEY_EVENT;         // 0633  /* We were interrupted by an event */
pub const KEY_MAX = c.KEY_MAX;             // 0777  /* Maximum key value is 0633 */

pub const WACS_BSSB = c.WACS_BSSB; // NCURSES_WACS('l')
pub const WACS_SSBB = c.WACS_SSBB; // NCURSES_WACS('m')
pub const WACS_BBSS = c.WACS_BBSS; // NCURSES_WACS('k')
pub const WACS_SBBS = c.WACS_SBBS; // NCURSES_WACS('j')
pub const WACS_SBSS = c.WACS_SBSS; // NCURSES_WACS('u')
pub const WACS_SSSB = c.WACS_SSSB; // NCURSES_WACS('t')
pub const WACS_SSBS = c.WACS_SSBS; // NCURSES_WACS('v')
pub const WACS_BSSS = c.WACS_BSSS; // NCURSES_WACS('w')
pub const WACS_BSBS = c.WACS_BSBS; // NCURSES_WACS('q')
pub const WACS_SBSB = c.WACS_SBSB; // NCURSES_WACS('x')
pub const WACS_SSSS = c.WACS_SSSS; // NCURSES_WACS('n')
pub const WACS_ULCORNER = c.WACS_ULCORNER;     // WACS_BSSB
pub const WACS_LLCORNER = c.WACS_LLCORNER;     // WACS_SSBB
pub const WACS_URCORNER = c.WACS_URCORNER;     // WACS_BBSS
pub const WACS_LRCORNER = c.WACS_LRCORNER;     // WACS_SBBS
pub const WACS_RTEE = c.WACS_RTEE;             // WACS_SBSS
pub const WACS_LTEE = c.WACS_LTEE;             // WACS_SSSB
pub const WACS_BTEE = c.WACS_BTEE;             // WACS_SSBS
pub const WACS_TTEE = c.WACS_TTEE;             // WACS_BSSS
pub const WACS_HLINE = c.WACS_HLINE;           // WACS_BSBS
pub const WACS_VLINE = c.WACS_VLINE;           // WACS_SBSB
pub const WACS_PLUS = c.WACS_PLUS;             // WACS_SSSS
pub const WACS_S1 = c.WACS_S1;                 // NCURSES_WACS('o') /* scan line 1 */
pub const WACS_S9 = c.WACS_S9;                 // NCURSES_WACS('s') /* scan line 9 */
pub const WACS_DIAMOND = c.WACS_DIAMOND;       // NCURSES_WACS('`') /* diamond */
pub const WACS_CKBOARD = c.WACS_CKBOARD;       // NCURSES_WACS('a') /* checker board */
pub const WACS_DEGREE = c.WACS_DEGREE;         // NCURSES_WACS('f') /* degree symbol */
pub const WACS_PLMINUS = c.WACS_PLMINUS;       // NCURSES_WACS('g') /* plus/minus */
pub const WACS_BULLET = c.WACS_BULLET;         // NCURSES_WACS('~') /* bullet */
pub const WACS_LARROW = c.WACS_LARROW;         // NCURSES_WACS(',') /* arrow left */
pub const WACS_RARROW = c.WACS_RARROW;         // NCURSES_WACS('+') /* arrow right */
pub const WACS_DARROW = c.WACS_DARROW;         // NCURSES_WACS('.') /* arrow down */
pub const WACS_UARROW = c.WACS_UARROW;         // NCURSES_WACS('-') /* arrow up */
pub const WACS_BOARD = c.WACS_BOARD;           // NCURSES_WACS('h') /* board of squares */
pub const WACS_LANTERN = c.WACS_LANTERN;       // NCURSES_WACS('i') /* lantern symbol */
pub const WACS_BLOCK = c.WACS_BLOCK;           // NCURSES_WACS('0') /* solid square block */
pub const WACS_S3 = c.WACS_S3;                 // NCURSES_WACS('p') /* scan line 3 */
pub const WACS_S7 = c.WACS_S7;                 // NCURSES_WACS('r') /* scan line 7 */
pub const WACS_LEQUAL = c.WACS_LEQUAL;         // NCURSES_WACS('y') /* less/equal */
pub const WACS_GEQUAL = c.WACS_GEQUAL;         // NCURSES_WACS('z') /* greater/equal */
pub const WACS_PI = c.WACS_PI;                 // NCURSES_WACS('{') /* Pi */
pub const WACS_NEQUAL = c.WACS_NEQUAL;         // NCURSES_WACS('|') /* not equal */
pub const WACS_STERLING = c.WACS_STERLING;     // NCURSES_WACS('}') /* UK pound sign */
pub const WACS_BDDB = c.WACS_BDDB;             // NCURSES_WACS('C')
pub const WACS_DDBB = c.WACS_DDBB;             // NCURSES_WACS('D')
pub const WACS_BBDD = c.WACS_BBDD;             // NCURSES_WACS('B')
pub const WACS_DBBD = c.WACS_DBBD;             // NCURSES_WACS('A')
pub const WACS_DBDD = c.WACS_DBDD;             // NCURSES_WACS('G')
pub const WACS_DDDB = c.WACS_DDDB;             // NCURSES_WACS('F')
pub const WACS_DDBD = c.WACS_DDBD;             // NCURSES_WACS('H')
pub const WACS_BDDD = c.WACS_BDDD;             // NCURSES_WACS('I')
pub const WACS_BDBD = c.WACS_BDBD;             // NCURSES_WACS('R')
pub const WACS_DBDB = c.WACS_DBDB;             // NCURSES_WACS('Y')
pub const WACS_DDDD = c.WACS_DDDD;             // NCURSES_WACS('E')
pub const WACS_D_ULCORNER = c.WACS_D_ULCORNER; // WACS_BDDB
pub const WACS_D_LLCORNER = c.WACS_D_LLCORNER; // WACS_DDBB
pub const WACS_D_URCORNER = c.WACS_D_URCORNER; // WACS_BBDD
pub const WACS_D_LRCORNER = c.WACS_D_LRCORNER; // WACS_DBBD
pub const WACS_D_RTEE = c.WACS_D_RTEE;         // WACS_DBDD
pub const WACS_D_LTEE = c.WACS_D_LTEE;         // WACS_DDDB
pub const WACS_D_BTEE = c.WACS_D_BTEE;         // WACS_DDBD
pub const WACS_D_TTEE = c.WACS_D_TTEE;         // WACS_BDDD
pub const WACS_D_HLINE = c.WACS_D_HLINE;       // WACS_BDBD
pub const WACS_D_VLINE = c.WACS_D_VLINE;       // WACS_DBDB
pub const WACS_D_PLUS = c.WACS_D_PLUS;         // WACS_DDDD
pub const WACS_BTTB = c.WACS_BTTB;             // NCURSES_WACS('L')
pub const WACS_TTBB = c.WACS_TTBB;             // NCURSES_WACS('M')
pub const WACS_BBTT = c.WACS_BBTT;             // NCURSES_WACS('K')
pub const WACS_TBBT = c.WACS_TBBT;             // NCURSES_WACS('J')
pub const WACS_TBTT = c.WACS_TBTT;             // NCURSES_WACS('U')
pub const WACS_TTTB = c.WACS_TTTB;             // NCURSES_WACS('T')
pub const WACS_TTBT = c.WACS_TTBT;             // NCURSES_WACS('V')
pub const WACS_BTTT = c.WACS_BTTT;             // NCURSES_WACS('W')
pub const WACS_BTBT = c.WACS_BTBT;             // NCURSES_WACS('Q')
pub const WACS_TBTB = c.WACS_TBTB;             // NCURSES_WACS('X')
pub const WACS_TTTT = c.WACS_TTTT;             // NCURSES_WACS('N')
pub const WACS_T_ULCORNER = c.WACS_T_ULCORNER; // WACS_BTTB
pub const WACS_T_LLCORNER = c.WACS_T_LLCORNER; // WACS_TTBB
pub const WACS_T_URCORNER = c.WACS_T_URCORNER; // WACS_BBTT
pub const WACS_T_LRCORNER = c.WACS_T_LRCORNER; // WACS_TBBT
pub const WACS_T_RTEE = c.WACS_T_RTEE;         // WACS_TBTT
pub const WACS_T_LTEE = c.WACS_T_LTEE;         // WACS_TTTB
pub const WACS_T_BTEE = c.WACS_T_BTEE;         // WACS_TTBT
pub const WACS_T_TTEE = c.WACS_T_TTEE;         // WACS_BTTT
pub const WACS_T_HLINE = c.WACS_T_HLINE;       // WACS_BTBT
pub const WACS_T_VLINE = c.WACS_T_VLINE;       // WACS_TBTB
pub const WACS_T_PLUS = c.WACS_T_PLUS;         // WACS_TTTT

pub const NCURSES_BUTTON_RELEASED: c_long = 0o1;
pub const NCURSES_BUTTON_PRESSED:  c_long = 0o2;
pub const NCURSES_BUTTON_CLICKED:  c_long = 0o4;
pub const NCURSES_DOUBLE_CLICKED:  c_long = 0o10;
pub const NCURSES_TRIPLE_CLICKED:  c_long = 0o20;
pub const NCURSES_RESERVED_EVENT:  c_long = 0o40;

pub const BUTTON1_RELEASED       : mmask_t = NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_RELEASED);
pub const BUTTON1_PRESSED        : mmask_t = NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_PRESSED);
pub const BUTTON1_CLICKED        : mmask_t = NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_CLICKED);
pub const BUTTON1_DOUBLE_CLICKED : mmask_t = NCURSES_MOUSE_MASK(1, NCURSES_DOUBLE_CLICKED);
pub const BUTTON1_TRIPLE_CLICKED : mmask_t = NCURSES_MOUSE_MASK(1, NCURSES_TRIPLE_CLICKED);
pub const BUTTON2_RELEASED       : mmask_t = NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_RELEASED);
pub const BUTTON2_PRESSED        : mmask_t = NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_PRESSED);
pub const BUTTON2_CLICKED        : mmask_t = NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_CLICKED);
pub const BUTTON2_DOUBLE_CLICKED : mmask_t = NCURSES_MOUSE_MASK(2, NCURSES_DOUBLE_CLICKED);
pub const BUTTON2_TRIPLE_CLICKED : mmask_t = NCURSES_MOUSE_MASK(2, NCURSES_TRIPLE_CLICKED);
pub const BUTTON3_RELEASED       : mmask_t = NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_RELEASED);
pub const BUTTON3_PRESSED        : mmask_t = NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_PRESSED);
pub const BUTTON3_CLICKED        : mmask_t = NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_CLICKED);
pub const BUTTON3_DOUBLE_CLICKED : mmask_t = NCURSES_MOUSE_MASK(3, NCURSES_DOUBLE_CLICKED);
pub const BUTTON3_TRIPLE_CLICKED : mmask_t = NCURSES_MOUSE_MASK(3, NCURSES_TRIPLE_CLICKED);
pub const BUTTON4_RELEASED       : mmask_t = NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_RELEASED);
pub const BUTTON4_PRESSED        : mmask_t = NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_PRESSED);
pub const BUTTON4_CLICKED        : mmask_t = NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_CLICKED);
pub const BUTTON4_DOUBLE_CLICKED : mmask_t = NCURSES_MOUSE_MASK(4, NCURSES_DOUBLE_CLICKED);
pub const BUTTON4_TRIPLE_CLICKED : mmask_t = NCURSES_MOUSE_MASK(4, NCURSES_TRIPLE_CLICKED);
pub const BUTTON5_RELEASED       : mmask_t = NCURSES_MOUSE_MASK(5, NCURSES_BUTTON_RELEASED);
pub const BUTTON5_PRESSED        : mmask_t = NCURSES_MOUSE_MASK(5, NCURSES_BUTTON_PRESSED);
pub const BUTTON5_CLICKED        : mmask_t = NCURSES_MOUSE_MASK(5, NCURSES_BUTTON_CLICKED);
pub const BUTTON5_DOUBLE_CLICKED : mmask_t = NCURSES_MOUSE_MASK(5, NCURSES_DOUBLE_CLICKED);
pub const BUTTON5_TRIPLE_CLICKED : mmask_t = NCURSES_MOUSE_MASK(5, NCURSES_TRIPLE_CLICKED);
pub const BUTTON_CTRL            : mmask_t = NCURSES_MOUSE_MASK(6, 0o1);
pub const BUTTON_SHIFT           : mmask_t = NCURSES_MOUSE_MASK(6, 0o2);
pub const BUTTON_ALT             : mmask_t = NCURSES_MOUSE_MASK(6, 0o4);
pub const REPORT_MOUSE_POSITION  : mmask_t = NCURSES_MOUSE_MASK(6, 0o10);
pub const ALL_MOUSE_EVENTS       : mmask_t = REPORT_MOUSE_POSITION - 1;

pub const TRACE_DISABLE = c.TRACE_DISABLE;
pub const TRACE_TIMES = c.TRACE_TIMES;
pub const TRACE_TPUTS = c.TRACE_TPUTS;
pub const TRACE_UPDATE = c.TRACE_UPDATE;
pub const TRACE_MOVE = c.TRACE_MOVE;
pub const TRACE_CHARPUT = c.TRACE_CHARPUT;
pub const TRACE_ORDINARY = c.TRACE_ORDINARY;
pub const TRACE_CALLS = c.TRACE_CALLS;
pub const TRACE_VIRTPUT = c.TRACE_VIRTPUT;
pub const TRACE_IEVENT = c.TRACE_IEVENT;
pub const TRACE_BITS = c.TRACE_BITS;
pub const TRACE_ICALLS = c.TRACE_ICALLS;
pub const TRACE_CCALLS = c.TRACE_CCALLS;
pub const TRACE_DATABASE = c.TRACE_DATABASE;
pub const TRACE_ATTRS = c.TRACE_ATTRS;

pub const TRACE_SHIFT = c.TRACE_SHIFT;
pub const TRACE_MAXIMUM = c.TRACE_MAXIMUM;

pub const OPTIMIZE_MVCUR = c.OPTIMIZE_MVCUR;
pub const OPTIMIZE_HASHMAP = c.OPTIMIZE_HASHMAP;
pub const OPTIMIZE_SCROLL = c.OPTIMIZE_SCROLL;
pub const OPTIMIZE_ALL = c.OPTIMIZE_ALL;

pub const KEY_F = c.KEY_F;                                 // (KEY_F0+(n)) /* Value of function key n */
pub const BUTTON_RELEASE = c.BUTTON_RELEASE;               // ((e) & NCURSES_MOUSE_MASK(x, 001))
pub const BUTTON_PRESS = c.BUTTON_PRESS;                   // ((e) & NCURSES_MOUSE_MASK(x, 002))
pub const BUTTON_CLICK = c.BUTTON_CLICK;                   // ((e) & NCURSES_MOUSE_MASK(x, 004))
pub const BUTTON_DOUBLE_CLICK = c.BUTTON_DOUBLE_CLICK;     // ((e) & NCURSES_MOUSE_MASK(x, 010))
pub const BUTTON_TRIPLE_CLICK = c.BUTTON_TRIPLE_CLICK;     // ((e) & NCURSES_MOUSE_MASK(x, 020))
pub const BUTTON_RESERVED_EVENT = c.BUTTON_RESERVED_EVENT; // ((e) & NCURSES_MOUSE_MASK(x, 040))
// zig fmt: on

//====================================================================
// Globals
//====================================================================

pub extern "ncurses" var ttytype: [*:0]const u8;
pub extern "ncurses" var COLORS: c_int;
pub extern "ncurses" var COLOR_PAIRS: c_int;
pub extern "ncurses" var COLS: c_int;
pub extern "ncurses" var ESCDELAY: c_int;
pub extern "ncurses" var LINES: c_int;
pub extern "ncurses" var TABSIZE: c_int;
pub var stdscr: Window = undefined;
pub var curscr: Window = undefined;
pub var newscr: Window = undefined;

//====================================================================
// Initialization
//====================================================================

pub fn initscr() !Window {
    const pointer = c.initscr();
    if (pointer) |ptr| {
        stdscr = Window{ .ptr = c.stdscr };
        curscr = Window{ .ptr = c.curscr };
        newscr = Window{ .ptr = c.newscr };
        return Window{ .ptr = ptr };
    } else {
        return NcursesError.GenericError;
    }
}
pub fn endwin() !void {
    if (c.endwin() == Err) return NcursesError.GenericError;
}
pub fn newwin(nlines: c_int, ncols: c_int, begin_y: c_int, begin_x: c_int) !Window {
    const pointer = c.newwin(nlines, ncols, begin_y, begin_x);
    if (pointer) |ptr| {
        return Window{ .ptr = ptr };
    } else {
        return NcursesError.GenericError;
    }
}

pub const Window = struct {
    ptr: *c._win_st,

    //====================================================================
    // Initialization and manipulation
    //====================================================================

    pub fn delwin(self: Window) !void {
        if (c.delwin(self.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn mvwin(self: Window, y: c_int, x: c_int) !void {
        if (c.mvwin(self.ptr, y, x) == Err) return NcursesError.GenericError;
    }
    pub fn subwin(self: Window, nlines: c_int, ncols: c_int, begin_y: c_int, begin_x: c_int) !Window {
        const pointer = c.subwin(self.ptr, nlines, ncols, begin_y, begin_x);
        if (pointer) |ptr| {
            return Window{ .ptr = ptr };
        } else {
            return NcursesError.GenericError;
        }
    }
    pub fn derwin(self: Window, nlines: c_int, ncols: c_int, begin_y: c_int, begin_x: c_int) !Window {
        const pointer = c.derwin(self.ptr, nlines, ncols, begin_y, begin_x);
        if (pointer) |ptr| {
            return Window{ .ptr = ptr };
        } else {
            return NcursesError.GenericError;
        }
    }
    pub fn mvderwin(self: Window, par_y: c_int, par_x: c_int) !void {
        if (c.mvderwin(self.ptr, par_y, par_x) == Err) return NcursesError.GenericError;
    }
    pub fn dupwin(self: Window) !Window {
        const pointer = c.dupwin(self.ptr);
        if (pointer) |ptr| {
            return Window{ .ptr = ptr };
        } else {
            return NcursesError.GenericError;
        }
    }
    pub fn wsyncup(self: Window) void {
        c.wsyncaup(self.ptr);
    }
    pub fn syncok(self: Window, bf: bool) !void {
        if (c.syncok(self.ptr, bf) == Err) return NcursesError.GenericError;
    }
    pub fn wcursyncup(self: Window) void {
        c.wcursyncup(self.ptr);
    }
    pub fn wsyncdown(self: Window) void {
        c.wsyncdown(self.ptr);
    }

    //====================================================================
    // Printing
    //====================================================================

    // FIXME: casting `format` to `[*:0]const u8` with `format.ptr` doesn't work, the string passed
    // in `args` argument must necessarily be a pointer already, probably a bug in Zig. Error:
    // error: TODO: support C ABI for more targets. https://github.com/ziglang/zig/issues/1481
    pub fn wprintw(self: Window, format: [:0]const u8, args: anytype) !void {
        if (@call(.{}, c.wprintw, .{ self.ptr, format.ptr } ++ args) == Err) return NcursesError.GenericError;
    }
    pub fn mvwprintw(self: Window, y: c_int, x: c_int, format: [:0]const u8, args: anytype) !void {
        if (@call(.{}, c.mvwprintw, .{ self.ptr, y, x, format.ptr } ++ args) == Err) return NcursesError.GenericError;
    }
    pub fn waddch(self: Window, ch: chtype) !void {
        if (c.waddch(self.ptr, ch) == Err) return NcursesError.GenericError;
    }
    pub fn mvwaddch(self: Window, y: c_int, x: c_int, ch: chtype) !void {
        if (c.mvwaddch(self.ptr, y, x, ch) == Err) return NcursesError.GenericError;
    }
    pub fn wechochar(self: Window, ch: chtype) !void {
        if (c.wechochar(self.ptr, ch) == Err) return NcursesError.GenericError;
    }
    pub fn waddstr(self: Window, str: [:0]const u8) !void {
        if (c.waddstr(self.ptr, str.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn waddnstr(self: Window, str: [:0]const u8, n: c_int) !void {
        if (c.waddnstr(self.ptr, str.ptr, n) == Err) return NcursesError.GenericError;
    }
    pub fn mvwaddstr(self: Window, y: c_int, x: c_int, str: [:0]const u8) !void {
        if (c.mvwaddstr(self.ptr, y, x, str.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn mvwaddnstr(self: Window, y: c_int, x: c_int, str: [:0]const u8, n: c_int) !void {
        if (c.mvwaddnstr(self.ptr, y, x, str.ptr, n) == Err) return NcursesError.GenericError;
    }

    //====================================================================
    // Printing with Zig (more fun)
    //====================================================================

    pub const Writer = std.io.Writer(Window, NcursesError, waddstrwrite);

    pub fn writer(self: Window) Writer {
        return .{ .context = self };
    }

    fn waddstrwrite(self: Window, str: []const u8) !usize {
        if (c.waddnstr(self.ptr, str.ptr, @intCast(c_int, str.len)) == Err) return NcursesError.GenericError;
        return str.len;
    }

    pub fn wprintwzig(self: Window, comptime format: []const u8, args: anytype) !void {
        try self.writer().print(format, args);
    }
    pub fn mvwprintwzig(self: Window, y: c_int, x: c_int, comptime format: []const u8, args: anytype) !void {
        try self.wmove(y, x);
        try self.writer().print(format, args);
    }
    pub fn waddstrzig(self: Window, str: []const u8) !void {
        try self.writer().writeAll(str);
    }
    pub fn mvwaddstrzig(self: Window, y: c_int, x: c_int, str: []const u8) !void {
        try self.wmove(y, x);
        try self.writer().writeAll(str);
    }
    pub const waddnstrzig = @compileError("not implemented: use `win.waddstrzig(str[0..n])` instead");
    pub const mvwaddnstrzig = @compileError("not implemented: use `win.mvwaddstrzig(str[0..n])` instead");

    //====================================================================
    // Input
    //====================================================================

    pub fn wgetch(self: Window) !c_int {
        const result = c.wgetch(self.ptr);
        if (result == Err) return NcursesError.GenericError;

        return result;
    }
    pub fn mvwgetch(self: Window, y: c_int, x: c_int) !c_int {
        const result = c.mvwgetch(self.ptr, y, x);
        if (result == Err) return NcursesError.GenericError;

        return result;
    }
    pub fn wscanw(self: Window, comptime format: [:0]const u8, args: anytype) !c_int {
        const result = @call(.{}, c.wprintw, .{ self.ptr, format } ++ args);
        if (result == Err) {
            return NcursesError.GenericError;
        } else {
            return result;
        }
    }
    pub fn mvwscanw(self: Window, y: c_int, x: c_int, comptime format: [:0]const u8, args: anytype) !c_int {
        const result = @call(.{}, c.wprintw, .{ self.ptr, y, x, format } ++ args);
        if (result == Err) {
            return NcursesError.GenericError;
        } else {
            return result;
        }
    }
    pub fn wgetstr(self: Window, str: [*:0]u8) !void {
        if (c.wgetstr(self.ptr, str) == Err) return NcursesError.GenericError;
    }
    pub fn wgetnstr(self: Window, str: [*:0]u8, n: c_int) !void {
        if (c.wgetstr(self.ptr, str, n) == Err) return NcursesError.GenericError;
    }
    pub fn mvwgetstr(self: Window, y: c_int, x: c_int, str: [*:0]u8) !void {
        if (c.mvwgetstr(self.ptr, y, x, str) == Err) return NcursesError.GenericError;
    }
    pub fn mvwgetnstr(self: Window, y: c_int, x: c_int, str: [*:0]u8, n: c_int) !void {
        if (c.mvwgetnstr(self.ptr, y, x, str, n) == Err) return NcursesError.GenericError;
    }

    //====================================================================
    // Character and window attribute control
    //====================================================================

    pub fn wattr_get(self: Window, attrs: *attr_t, pair: *c_short, opts: ?*c_void) !void {
        if (c.wattr_get(self.ptr, attrs, pair, opts) == Err) return NcursesError.GenericError;
    }
    pub fn wattr_set(self: Window, attrs: attr_t, pair: c_short, opts: ?*c_void) !void {
        if (c.wattr_set(self.ptr, attrs, pair, opts) == Err) return NcursesError.GenericError;
    }
    pub fn wattr_off(self: Window, attrs: attr_t, opts: ?*c_void) !void {
        if (c.wattr_off(self.ptr, attrs, opts) == Err) return NcursesError.GenericError;
    }
    pub fn wattr_on(self: Window, attrs: attr_t, opts: ?*c_void) !void {
        if (c.wattr_on(self.ptr, attrs, opts) == Err) return NcursesError.GenericError;
    }
    pub fn wattroff(self: Window, attrs: c_int) !void {
        if (c.wattroff(self.ptr, attrs) == Err) return NcursesError.GenericError;
    }
    pub fn wattron(self: Window, attrs: c_int) !void {
        if (c.wattron(self.ptr, attrs) == Err) return NcursesError.GenericError;
    }
    pub fn wattrset(self: Window, attrs: c_int) !void {
        if (c.wattrset(self.ptr, attrs) == Err) return NcursesError.GenericError;
    }
    pub fn wchgat(self: Window, n: c_int, attr: attr_t, pair: c_short, opts: ?*const c_void) !void {
        if (c.wchgat(self.ptr, n, attr, pair, opts) == Err) return NcursesError.GenericError;
    }
    pub fn mvwchgat(self: Window, y: c_int, x: c_int, n: c_int, attr: attr_t, pair: c_short, opts: ?*const c_void) !void {
        if (c.mvwchgat(self.ptr, y, x, n, attr, pair, opts) == Err) return NcursesError.GenericError;
    }

    //====================================================================
    // Refresh windows and lines
    //====================================================================

    pub fn wrefresh(self: Window) !void {
        if (c.wrefresh(self.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn wnoutrefresh(self: Window) !void {
        if (c.wnoutrefresh(self.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn redrawwin(self: Window) !void {
        if (c.redrawwin(self.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn wredrawln(self: Window, beg_line: c_int, num_lines: c_int) !void {
        if (c.wredrawln(self.ptr, beg_line, num_lines) == Err) return NcursesError.GenericError;
    }

    //====================================================================
    // Coordinates
    //====================================================================

    pub fn getyx(self: Window, y: *c_int, x: *c_int) !void {
        y.* = try getcury(self);
        x.* = try getcurx(self);
    }
    pub inline fn getcury(self: Window) !c_int {
        const result = c.getcury(self.ptr);
        if (result == Err) {
            return NcursesError.GenericError;
        } else {
            return result;
        }
    }
    pub inline fn getcurx(self: Window) !c_int {
        const result = c.getcurx(self.ptr);
        if (result == Err) {
            return NcursesError.GenericError;
        } else {
            return result;
        }
    }
    pub fn getbegyx(self: Window, y: *c_int, x: *c_int) !void {
        y.* = try getbegy(self);
        x.* = try getbegx(self);
    }
    pub inline fn getbegy(self: Window) !c_int {
        const result = c.getbegy(self.ptr);
        if (result == Err) {
            return NcursesError.GenericError;
        } else {
            return result;
        }
    }
    pub inline fn getbegx(self: Window) !c_int {
        const result = c.getbegx(self.ptr);
        if (result == Err) {
            return NcursesError.GenericError;
        } else {
            return result;
        }
    }
    pub fn getmaxyx(self: Window, y: *c_int, x: *c_int) !void {
        y.* = try getmaxy(self);
        x.* = try getmaxx(self);
    }
    pub inline fn getmaxy(self: Window) !c_int {
        const result = c.getmaxy(self.ptr);
        if (result == Err) {
            return NcursesError.GenericError;
        } else {
            return result;
        }
    }
    pub inline fn getmaxx(self: Window) !c_int {
        const result = c.getmaxx(self.ptr);
        if (result == Err) {
            return NcursesError.GenericError;
        } else {
            return result;
        }
    }
    pub fn getparyx(self: Window, y: *c_int, x: *c_int) !void {
        y.* = try getpary(self);
        x.* = try getparx(self);
    }
    pub inline fn getpary(self: Window) !c_int {
        const result = c.getpary(self.ptr);
        if (result == Err) {
            return NcursesError.GenericError;
        } else {
            return result;
        }
    }
    pub inline fn getparx(self: Window) !c_int {
        const result = c.getparx(self.ptr);
        if (result == Err) {
            return NcursesError.GenericError;
        } else {
            return result;
        }
    }

    //====================================================================
    // Movement
    //====================================================================

    pub fn wmove(self: Window, y: c_int, x: c_int) !void {
        if (c.wmove(self.ptr, y, x) == Err) return NcursesError.GenericError;
    }

    //====================================================================
    // Clearing
    //====================================================================

    pub fn werase(self: Window) !void {
        if (c.werase(self.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn wclear(self: Window) !void {
        if (c.wclear(self.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn wclrtobot(self: Window) !void {
        if (c.wclrtobot(self.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn wclrtoeol(self: Window) !void {
        if (c.wclrtoeol(self.ptr) == Err) return NcursesError.GenericError;
    }

    //====================================================================
    // Borders, lines
    //====================================================================

    pub fn wborder(self: Window, ls: chtype, rs: chtype, ts: chtype, bs: chtype, tl: chtype, tr: chtype, bl: chtype, br: chtype) !void {
        if (c.wborder(self.ptr, ls, rs, ts, bs, tl, tr, bl, br) == Err) return NcursesError.GenericError;
    }
    pub fn box(self: Window, verch: chtype, horch: chtype) !void {
        if (c.box(self.ptr, verch, horch) == Err) return NcursesError.GenericError;
    }
    pub fn whline(self: Window, ch: chtype, n: c_int) !void {
        if (c.whline(self.ptr, ch, n) == Err) return NcursesError.GenericError;
    }
    pub fn wvline(self: Window, ch: chtype, n: c_int) !void {
        if (c.wvline(self.ptr, ch, n) == Err) return NcursesError.GenericError;
    }
    pub fn mvwhline(self: Window, y: c_int, x: c_int, ch: chtype, n: c_int) !void {
        if (c.mvwhline(self.ptr, y, x, ch, n) == Err) return NcursesError.GenericError;
    }
    pub fn mvwvline(self: Window, y: c_int, x: c_int, ch: chtype, n: c_int) !void {
        if (c.mvwvline(self.ptr, y, x, ch, n) == Err) return NcursesError.GenericError;
    }

    pub fn keypad(self: Window, bf: bool) !void {
        if (c.keypad(self.ptr, bf) == Err) return NcursesError.GenericError;
    }

    //====================================================================
    // Mouse
    //====================================================================

    pub fn wenclose(self: Window, y: c_int, x: c_int) bool {
        return c.wenclose(self.ptr, y, x);
    }
    pub fn wmouse_trafo(self: Window, pY: c_int, pX: c_int, to_screen: bool) bool {
        return c.wmouse_trafo(self.ptr, pY, pX, to_screen);
    }

    //====================================================================
    // Utility functions
    //====================================================================

    pub fn putwin(self: Window, file: c.FILE) !void {
        if (c.putwin(file) == Err) return NcursesError.GenericError;
    }

    //====================================================================
    // Overlay
    //====================================================================

    pub fn overlay(srcwin: Window, dstwin: Window) !void {
        if (c.overlay(srcwin.ptr, dstwin.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn overwrite(srcwin: Window, dstwin: Window) !void {
        if (c.overwrite(srcwin.ptr, dstwin.ptr) == Err) return NcursesError.GenericError;
    }
    pub fn copywin(
        srcwin: Window,
        dstwin: Window,
        sminrow: c_int,
        smincol: c_int,
        dminrow: c_int,
        dmincol: c_int,
        dmaxrow: c_int,
        dmaxcol: c_int,
        overlay: c_int,
    ) !void {
        if (c.copywin(
            srcwin.ptr,
            dstwin.ptr,
            sminrow,
            smincol,
            dminrow,
            dmincol,
            dmaxrow,
            dmaxcol,
            overlay,
        ) == Err) return NcursesError.GenericError;
    }
};

//====================================================================
// Printing
//====================================================================

pub inline fn printw(comptime format: [:0]const u8, args: anytype) !void {
    return try stdscr.wprintw(format, args);
}
pub inline fn mvprintw(y: c_int, x: c_int, comptime format: [:0]const u8, args: anytype) !void {
    return try stdscr.mvwprintw(y, x, format, args);
}
pub inline fn addch(ch: chtype) !void {
    return try stdscr.waddch(ch);
}
pub inline fn mvaddch(y: c_int, x: c_int, ch: chtype) !void {
    return try stdscr.mvwaddch(y, x, ch);
}
pub inline fn echochar(ch: chtype) !void {
    return try stdscr.wechochar(ch);
}
pub inline fn addstr(str: [:0]const u8) !void {
    return try stdscr.waddstr(str);
}
pub inline fn addnstr(str: [:0]const u8, n: c_int) !void {
    return try stdscr.waddnstr(str, n);
}
pub inline fn mvaddstr(y: c_int, x: c_int, str: [:0]const u8) !void {
    return try stdscr.mvwaddstr(y, x, str);
}
pub inline fn mvaddnstr(y: c_int, x: c_int, str: [:0]const u8, n: c_int) !void {
    return try stdscr.mvwaddnstr(y, x, str, n);
}

//====================================================================
// Printing with Zig (more fun)
//====================================================================

pub inline fn printwzig(comptime format: []const u8, args: anytype) !void {
    return try stdscr.wprintwzig(format, args);
}
pub inline fn mvprintwzig(y: c_int, x: c_int, comptime format: []const u8, args: anytype) !void {
    return try stdscr.mvwprintwzig(y, x, format, args);
}
pub inline fn addstrzig(str: []const u8) !void {
    return try stdscr.waddstrzig(str);
}
pub inline fn mvaddstrzig(y: c_int, x: c_int, str: []const u8) !void {
    return try stdscr.mvwaddstrzig(y, x, str);
}
pub const addnstrzig = @compileError("not implemented: use `addstrzig(str[0..n])` instead");
pub const mvaddnstrzig = @compileError("not implemented: use `mvaddstrzig(str[0..n])` instead");

//====================================================================
// Input
//====================================================================

pub inline fn getch() !c_int {
    return try stdscr.wgetch();
}
pub inline fn mvgetch(y: c_int, x: c_int) !c_int {
    return try stdscr.mvwgetch(y, x);
}
pub fn ungetch(ch: c_int) !void {
    if (c.ungetch(ch) == Err) return NcursesError.GenericError;
}
pub fn has_key(ch: c_int) bool {
    return c.has_key(ch) == True;
}
pub inline fn scanw(comptime format: [:0]const u8, args: anytype) !c_int {
    return try stdscr.wscanw(format, args);
}
pub inline fn mvscanw(y: c_int, x: c_int, comptime format: [:0]const u8, args: anytype) !c_int {
    return try stdscr.mvwscanw(format, args);
}
pub inline fn getstr(str: [*:0]u8) !void {
    return try stdscr.wgetstr(str);
}
pub inline fn getnstr(str: [*:0]u8, n: c_int) !void {
    return try stdscr.wgetnstr(str, n);
}
pub inline fn mvgetstr(y: c_int, x: c_int, str: [*:0]u8) !void {
    return try stdscr.mvwgetstr(y, x, str);
}
pub inline fn mvgetnstr(y: c_int, x: c_int, str: [*:0]u8, n: c_int) !void {
    return try stdscr.mvwgetnstr(y, x, str, n);
}

//====================================================================
// Input options
//====================================================================

pub fn cbreak() !void {
    if (c.cbreak() == Err) return NcursesError.GenericError;
}
pub fn nocbreak() !void {
    if (c.nocbreak() == Err) return NcursesError.GenericError;
}
pub fn echo() !void {
    if (c.echo() == Err) return NcursesError.GenericError;
}
pub fn noecho() !void {
    if (c.noecho() == Err) return NcursesError.GenericError;
}
pub fn raw() !void {
    if (c.raw() == Err) return NcursesError.GenericError;
}
pub fn noraw() !void {
    if (c.noraw() == Err) return NcursesError.GenericError;
}

//====================================================================
// Character and window attribute control
//====================================================================

pub inline fn attr_get(attrs: *attr_t, pair: *c_short, opts: ?*c_void) !void {
    return try stdscr.wattr_get(attrs, pair, opts);
}
pub inline fn attr_set(attrs: attr_t, pair: c_short, opts: ?*c_void) !void {
    return try stdscr.wattr_set(attrs, pair, opts);
}
pub inline fn attr_off(attrs: attr_t, opts: ?*c_void) !void {
    return try stdscr.wattr_off(attrs, opts);
}
pub inline fn attr_on(attrs: attr_t, opts: ?*c_void) !void {
    return try stdscr.wattr_on(attrs, opts);
}
pub inline fn attroff(attrs: c_int) !void {
    return try stdscr.wattroff(attrs);
}
pub inline fn attron(attrs: c_int) !void {
    return try stdscr.wattron(attrs);
}
pub inline fn attrset(attrs: c_int) !void {
    return try stdscr.wattrset(attrs);
}
pub inline fn chgat(n: c_int, attr: attr_t, pair: c_short, opts: ?*const c_void) !void {
    return try stdscr.wchgat(n, attr, pair, opts);
}
pub inline fn mvchgat(y: c_int, x: c_int, n: c_int, attr: attr_t, pair: c_short, opts: ?*const c_void) !void {
    return try stdscr.mvwchgat(y, x, n, attr, pair, opts);
}

//====================================================================
// Refresh windows and lines
//====================================================================

pub inline fn refresh() !void {
    return try stdscr.wrefresh();
}
pub fn doupdate() !void {
    if (c.doupdate() == Err) return NcursesError.GenericError;
}

//====================================================================
// Movement
//====================================================================

pub inline fn move(y: c_int, x: c_int) !void {
    return try stdscr.wmove(y, x);
}

//====================================================================
// Clearing
//====================================================================

pub inline fn erase() !void {
    return try stdscr.werase();
}
pub inline fn clear() !void {
    return try stdscr.wclear();
}
pub inline fn clrtobot() !void {
    return try stdscr.wclrtobot();
}
pub inline fn clrtoeol() !void {
    return try stdscr.wclrtoeol();
}

//====================================================================
// Borders, lines
//====================================================================

pub inline fn border(ls: chtype, rs: chtype, ts: chtype, bs: chtype, tl: chtype, tr: chtype, bl: chtype, br: chtype) !void {
    return try stdscr.wborder(ls, rs, ts, bs, tl, tr, bl, br);
}
pub inline fn hline(ch: chtype, n: c_int) !void {
    return try stdscr.whline(ch, n);
}
pub inline fn vline(ch: chtype, n: c_int) !void {
    return try stdscr.wvline(ch, n);
}
pub inline fn mvhline(y: c_int, x: c_int, ch: chtype, n: c_int) !void {
    return try stdscr.mvwhline(y, x, ch, n);
}
pub inline fn mvvline(y: c_int, x: c_int, ch: chtype, n: c_int) !void {
    return try stdscr.mvwvline(y, x, ch, n);
}

//====================================================================
// Mouse
//====================================================================

pub fn has_mouse() bool {
    return c.has_mouse();
}
pub fn getmouse(event: *MEVENT) !void {
    if (c.getmouse(@ptrCast(*c.MEVENT, event)) == Err) return NcursesError.GenericError;
}
pub fn ungetmouse(event: *MEVENT) !void {
    if (c.ungetmouse(@ptrCast(*c.MEVENT, event)) == Err) return NcursesError.GenericError;
}
pub fn mousemask(newmask: mmask_t, oldmask: ?*mmask_t) mmask_t {
    return c.mousemask(newmask, oldmask orelse null);
}
pub inline fn mouse_trafo(pY: *c_int, pX: *c_int, to_screen: bool) bool {
    return stdscr.wmouse_trafo(pY, pX, to_screen);
}
// mouseinterval  returns the previous interval value, unless the terminal was not initialized.
// Inthat case, it returns the maximum interval value (166).
pub fn mouseinterval(erval: c_int) !c_int {
    const result = c.mouseinterval(erval);
    if (result == 166) {
        return NcursesError.GenericError;
    } else {
        return result;
    }
}

//====================================================================
// Colors
//====================================================================

pub fn start_color() !void {
    if (c.start_color() == Err) return NcursesError.GenericError;
}
pub fn has_colors() bool {
    return c.has_colors();
}
pub fn can_change_color() bool {
    return c.can_change_color();
}
pub fn init_pair(pair: c_short, f: c_short, b: c_short) !void {
    if (c.init_pair(pair, f, b) == Err) return NcursesError.GenericError;
}
pub fn init_color(color: c_short, r: c_short, g: c_short, b: c_short) !void {
    if (c.init_color(color, r, g, b) == Err) return NcursesError.GenericError;
}
pub fn init_extended_pair(pair: c_int, f: c_int, b: c_int) !void {
    if (c.init_pair(pair, f, b) == Err) return NcursesError.GenericError;
}
pub fn init_extended_color(color: c_int, r: c_int, g: c_int, b: c_int) !void {
    if (c.init_color(color, r, g, b) == Err) return NcursesError.GenericError;
}
pub fn pair_content(pair: c_short, f: *c_short, b: *c_short) !void {
    if (c.color_content(pair, f, b) == Err) return NcursesError.GenericError;
}
pub fn color_content(color: c_short, r: *c_short, g: *c_short, b: *c_short) !void {
    if (c.color_content(color, r, g, b) == Err) return NcursesError.GenericError;
}
pub fn extended_pair_content(pair: c_int, f: *c_int, b: *c_int) !void {
    if (c.color_content(pair, f, b) == Err) return NcursesError.GenericError;
}
pub fn extended_color_content(color: c_int, r: *c_int, g: *c_int, b: *c_int) !void {
    if (c.color_content(color, r, g, b) == Err) return NcursesError.GenericError;
}
pub fn reset_color_pairs() void {
    c.reset_color_pairs();
}
pub fn pair_number(attrs: c_int) c_int {
    return @intCast(
        c_int,
        ((@intCast(c_ulong, attrs) & @enumToInt(Attribute.color)) >> Attribute.default_shift),
    );
}
pub fn color_pair(n: c_int) c_int {
    return ncursesBits(n, 0) & @enumToInt(Attribute.color);
}

//====================================================================
// Screen dump/restore
//====================================================================

pub fn scr_dump(filename: [:0]const u8) !void {
    if (c.scr_dump(filename.ptr) == Err) return NcursesError.GenericError;
}
pub fn scr_restore(filename: [:0]const u8) !void {
    if (c.scr_restore(filename.ptr) == Err) return NcursesError.GenericError;
}
pub fn scr_init(filename: [:0]const u8) !void {
    if (c.scr_init(filename.ptr) == Err) return NcursesError.GenericError;
}
pub fn scr_set(filename: [:0]const u8) !void {
    if (c.scr_set(filename.ptr) == Err) return NcursesError.GenericError;
}

//====================================================================
// Utility functions
//====================================================================

pub fn unctrl(ch: chtype) ![*:0]const u8 {
    if (c.unctrl(ch)) |result| {
        return result;
    } else {
        return NcursesError.GenericError;
    }
}
pub fn wunctrl(ch: cchar_t) ![*:0]const wchar_t {
    if (c.wunctrl(ch)) |result| {
        return result;
    } else {
        return NcursesError.GenericError;
    }
}
pub fn keyname(ch: c_int) ![*:0]const u8 {
    if (c.keyname(ch)) |result| {
        return result;
    } else {
        return NcursesError.GenericError;
    }
}
pub fn key_name(ch: wchar_t) ![*:0]const u8 {
    if (c.keyname(ch)) |result| {
        return result;
    } else {
        return NcursesError.GenericError;
    }
}
pub fn filter() void {
    c.filter();
}
pub fn nofilter() void {
    c.nofilter();
}
pub fn use_env(f: bool) void {
    c.use_env(f);
}
pub fn use_tioctl(f: bool) void {
    c.use_tioctl(f);
}
pub fn getwin(file: c.FILE) Window {
    if (c.getwin(file)) |winptr| {
        return Window{ .ptr = winptr };
    } else {
        return NcursesError.GenericError;
    }
}
pub fn delay_output(ms: c_int) !void {
    if (c.delay_output(ms) == Err) return NcursesError.GenericError;
}
pub fn flushinp() !void {
    if (c.flushinp() == Err) return NcursesError.GenericError;
}
