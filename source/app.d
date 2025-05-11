import std.stdio;
import std.format;
import std.conv;
import e          : E,E_Container;
import klass      : Klass;
import vf.l       : L,LC,LL;
import vf.located : Container,Located,Projector,Target;
import vf.tree    : Tree;


void 
main (string[] args) {
    import vf.located;
    vf.located.go ();
    writeln ("OK");
}

void
test_3 () {
    auto i_root      = IStyled_Container ();

    auto i_rect_ul_1 = IStyled ();
    auto i_rect_ul_2 = IStyled ();
    auto i_rect_ul_3 = IStyled ();

    auto i_rect_uc_1 = IStyled ();
    auto i_rect_uc_2 = IStyled ();
    auto i_rect_uc_3 = IStyled ();

    auto i_rect_ur_1 = IStyled ();
    auto i_rect_ur_2 = IStyled ();
    auto i_rect_ur_3 = IStyled ();

    i_root.content ~= i_rect_ul_1;
    i_root.content ~= i_rect_ul_2;
    i_root.content ~= i_rect_ul_3;
    i_root.content ~= i_rect_uc_1;
    i_root.content ~= i_rect_uc_2;
    i_root.content ~= i_rect_uc_3;
    i_root.content ~= i_rect_ur_1;
    i_root.content ~= i_rect_ur_2;
    i_root.content ~= i_rect_ur_3;

    //
    auto _istyle_root = IStyle.NEW (
        "loc cc", 
        "len 640,480"
    );

    auto istyle_root_ = IStyle.NEW ();
    with (istyle_root_) {
        defined.loc = "cc";
        defined.len = [640,480];
    }

    auto istyle_root = IStyle.NEW ();
    with (istyle_root) {
        defined.loc = "cc";
        defined.len = [640,480];
    }

    auto istyle_e = IStyle.NEW ();
    with (istyle_root) {
        defined.loc = [0,0];
        defined.len = [0,0];
    }

    auto istyle_rect = IStyle.NEW ();
    with (istyle_rect) {
        defined.len = [64,64];
    }

    auto istyle_ul   = IStyle.NEW ();
    with (istyle_rect) {
        defined.loc = "ul";
        defined.way = "rd";
    }

    auto istyle_uc   = IStyle.NEW ();
    with (istyle_rect) {
        defined.loc = "uc";
        defined.way = "rd";
    }

    auto istyle_ur   = IStyle.NEW ();
    with (istyle_rect) {
        defined.loc = "ur";
        defined.way = "ld";
    }

    //
    i_root      = istyle_root;

    i_rect_ul_1 = istyle_e;
    i_rect_ul_1 = istyle_rect;
    i_rect_ul_1 = istyle_ul;

    i_rect_uc_1 = istyle_e;
    i_rect_uc_1 = istyle_rect;
    i_rect_uc_1 = istyle_uc;

    i_rect_ur_1 = istyle_e;
    i_rect_ur_1 = istyle_rect;
    i_rect_ur_1 = istyle_ur;

    //
    auto target = new Target (L ([640,480]));
    //Projector ().project (e_root,target);
}

struct
Event {
    E*       root;
    Styles*  styles;
    Path*    path;
    Window*  window;

    struct
    Styles {
        //
    }

    struct
    Path {
        //
    }

    struct
    Window {
        //
    }
}

// E - Resource
// Tree - i[] -> Resources[i]
//
// Resources[] = [E0,E1,E2,E3]
// Tree = E0 [E1,E2,E3]

// Audacious
// iFile iPlay iList iServices iExit iView \n
// iSearch iOpen iAdd iProgress iTime \n
// iPlaylist \n
// iSongInfo \n
// iStatus
//
// iProgress
//   expand_len_x

// Top Bar
// iLeftUp
//   1 2 3 \n
// iCenterUp
//   1 2 3 \n
// iRightUp
//   1 2 3 \n
//
// iLeftUp
//   way    r
// iCenterUp
//   expand_len_x
//   magnet center
//   way    r
// iRightUp
//   way    l

struct
I {
    char i;  // char wchar dchar size_t
}

struct
IStyled {
    I      i;  // char wchar dchar size_t
    IStyle istyle;

    void
    opAssign (IStyle b) {
        istyle = b;
    }
}

struct
IStyle {
    char           i;
    static Style[] s;

    static
    IStyle
    NEW (ARGS...) (ARGS args) {
        s.length++;
        return IStyle ((s.length-1).to!char);
    }

    auto ref defined () { return s[i].defined; }
}

struct
Style {
    Located located;
    // Located
    //   loc
    //   len
    // Colored
    //   color
    // Fonted
    //   font
    Defined defined;
}

// I + IStyle = IStyled
// IStyle_1 + IStyle_2 = IStyle_3

struct
IStyled_Container {
    // defined
    IStyled[] s;
    // projected
    LL[]      ll;

    alias content = s;

    void
    opAssign (IStyle b) {
        //
    }
}

//
Defined defined;
struct
Defined {
    LC    _loc;
    LC    _len;
    Flags _flags;  // way

    auto ref loc (string b) { cast (Loc) (_loc)  = b;}
    auto ref len (int[2] b) { cast (Len) (_len)  = b;}
    auto ref way (string b) { cast (Way) (_flags) = b;}

    struct
    Flags {
        ubyte s;

        enum 
        Mask : typeof (s) {
            overflow_wrap = 0b0000_0001,
            way_0_x       = 0b0000_0010,
            way_0_y       = 0b0000_0100,
            way_1_x       = 0b0000_1000,
            way_1_y       = 0b0001_0000,
        }
    }
}
struct
Loc {
    LC loc;

    void
    opAssign (string b) {
        if (b.length > 0) {
            switch (b[0]) {
                case 'l' : loc.len.s[0] = 0; loc.cap.s[0] = 2; break;
                case 'c' : loc.len.s[0] = 1; loc.cap.s[0] = 2; break;
                case 'r' : loc.len.s[0] = 2; loc.cap.s[0] = 2; break;
                default  :
            }
        }
        else
        if (b.length > 1) {
            switch (b[1]) {
                case 'u' : loc.len.s[1] = 0; loc.cap.s[1] = 2; break;
                case 'c' : loc.len.s[1] = 1; loc.cap.s[1] = 2; break;
                case 'd' : loc.len.s[1] = 2; loc.cap.s[1] = 2; break;
                default  :
            }
        }
    }
}

struct
Len {
    LC len;

    void
    opAssign (int[2] b) {
        // [640,480]
        len.len.s[0] = b[0];
        len.cap.s[0] = 1;
        len.len.s[1] = b[1];
        len.cap.s[1] = 1;
    }
}

struct
Way {
    Klass.Defined.Flags flags;

    void
    opAssign (string b) {
        if (b.length > 0) {
            switch (b[0]) {
                case 'u' : flags.s &= !flags.Mask.way_0_y; break;
                case 'd' : flags.s |=  flags.Mask.way_0_y; break;
                case 'r' : flags.s &= !flags.Mask.way_0_x; break;
                case 'l' : flags.s |=  flags.Mask.way_0_x; break;
                default  :
            }
        }
        else
        if (b.length > 1) {
            switch (b[1]) {
                case 'u' : flags.s &= !flags.Mask.way_1_y; break;
                case 'd' : flags.s |=  flags.Mask.way_1_y; break;
                case 'r' : flags.s &= !flags.Mask.way_1_x; break;
                case 'l' : flags.s |=  flags.Mask.way_1_x; break;
                default  :
            }
        }
    }
}

