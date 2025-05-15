import std.stdio;
import std.format;
import std.conv;
import std.algorithm;
import e          : E,E_Container;
import vf.l       : L,LC,LL;
import vf.located : Container,Locate,Projector,Target;
import vf.tree    : Tree;


void 
main (string[] args) {
    import vf.located;
    vf.located.go ();
    go ("2");
    writeln ("OK");
}

void
test_3 () {
    auto e_root      = IE_Container ();

    auto e_rect_ul_1 = IE ();
    auto e_rect_ul_2 = IE ();
    auto e_rect_ul_3 = IE ();

    auto e_rect_uc_1 = IE ();
    auto e_rect_uc_2 = IE ();
    auto e_rect_uc_3 = IE ();

    auto e_rect_ur_1 = IE ();
    auto e_rect_ur_2 = IE ();
    auto e_rect_ur_3 = IE ();

    e_root.content ~= e_rect_ul_1;
    e_root.content ~= e_rect_ul_2;
    e_root.content ~= e_rect_ul_3;
    e_root.content ~= e_rect_uc_1;
    e_root.content ~= e_rect_uc_2;
    e_root.content ~= e_rect_uc_3;
    e_root.content ~= e_rect_ur_1;
    e_root.content ~= e_rect_ur_2;
    e_root.content ~= e_rect_ur_3;

    //
    auto _style_root = IStyle.NEW (
        "loc cc", 
        "len 640,480"
    );

    auto style_root_ = IStyle.NEW ();
    with (style_root_) {
        defined.loc = "cc";
        defined.len = [640,480];
    }

    auto style_root = IStyle.NEW ();
    with (style_root) {
        defined.loc = "cc";
        defined.len = [640,480];
    }

    auto style_e = IStyle.NEW ();
    with (style_e) {
        defined.loc = [0,0];
        defined.len = [0,0];
    }

    auto style_rect = IStyle.NEW ();
    with (style_rect) {
        defined.len = [64,64];
    }

    auto style_ul   = IStyle.NEW ();
    with (style_rect) {
        defined.loc = "ul";
//        defined.way = "rd";
    }

    auto style_uc   = IStyle.NEW ();
    with (style_rect) {
        defined.loc = "uc";
//        defined.way = "rd";
    }

    auto style_ur   = IStyle.NEW ();
    with (style_rect) {
        defined.loc = "ur";
//        defined.way = "ld";
    }

    //
    e_root = style_root;

    e_rect_ul_1.defined.styles ~= style_e;
    e_rect_ul_1.defined.styles ~= style_rect;
    e_rect_ul_1.defined.styles ~= style_ul;

    e_rect_uc_1.defined.styles ~= style_e;
    e_rect_uc_1.defined.styles ~= style_rect;
    e_rect_uc_1.defined.styles ~= style_uc;

    e_rect_ur_1.defined.styles ~= style_e;
    e_rect_ur_1.defined.styles ~= style_rect;
    e_rect_ur_1.defined.styles ~= style_ur;

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
    // mixin S!I;
}

enum I_MAX      = I.i.max;
enum STYLES_MAX = IStyle.i.max;

struct
IStyle {
    char            i;  // style index

    //
    static _Style[] s;  // all styles

    static
    this () {
        s.reserve (STYLES_MAX);
    }

    static
    IStyle
    NEW (ARGS...) (ARGS args) {
        s.length++;
        return IStyle ((s.length-1).to!(typeof(i)));
    }

    auto ref defined () { return s[i].defined; }

    // Style_1 + Style_2 = Style_3
    IStyle
    opBinary (string op : "+") (IStyle b) {
        alias a = this;
        IStyle style = IStyle.NEW ();
        // search style with [a.i, b.i]
        //   use
        // or
        //   create
        IStyle.s[style.i] = IStyle.s[a.i] + IStyle.s[b.i];
        return style;
    }
}

struct
_Style {
    Defined   defined;
    //Projected projected;  // in E.projected.style

    struct
    Defined {        
        Locate.Defined  locate;
        Color .Defined  color;
        Content.Defined content;

        //auto ref loc ()         { return cast (Loc) (locate.loc); }
        void     loc (string b) { cast (Loc) (locate.loc)   = b; }
        void     len (int[2] b) { cast (Len) (locate.len)   = b; }
        
//        void     way (string b) { cast (Way) (container_locate.flags) = b; }
        // Locate
        //   loc
        //   len
        // Color
        //   color
        // Image
        //   image.src
        // Text
        //   text.font
        //   text.char_len.x
        //   text.char_len.y
        // Childs
        //   childs
    }

    struct
    Projected {
        Locate .Projected locate;
        Color  .Projected  color;
        Content.Projected  content;
    }

    _Style
    opBinary (string op : "+") (_Style b) {
        alias a = this;
        _Style style = _Style ();
        style.locate  = a.locate  + b.locate;
        style.defined = a.defined + b.defined;
        return style;
    }
}

struct
Content {
    struct
    Defined {
        //
    }

    struct
    Projected {
        union {
            Type               type;  // image, text, childs
            _Image .Projected  image;
            _Text  .Projected  text;
            _Childs.Projected  childs;
        }                
    }

    enum
    Type : byte {
        _,
        image,
        text,
        childs,
    }

    struct
    _Image {
        Type type = Type.image;

        struct
        Defined {
            //
        }
        struct
        Projected {
            //
        }
    }

    struct
    _Text {
        Type type = Type.text;

        struct
        Defined {
            //
        }
        struct
        Projected {
            //
        }
    }

    struct
    _Childs {
        Type type = Type.childs;

        struct
        Defined {
            //
        }
        struct
        Projected {
            //
        }
    }
}

// I + Style  = IStyled
// I + Locate = ILocated
alias IStyled  = _I!_Style;
alias ILocated = _I!Locate;

struct
_I (T) {  // I + T
    I          i;
    static T[] s;

    static
    this () {
        s.reserve (I_MAX);
    }

    auto ref
    opIndex (I i) {
        return s[i.i];
    }

    void
    opAssign (T b) {
        s[i.i] = b;
    }
}


struct
IE {
    char        i;
    //
    static _E[] s;

    auto ref defined () { return s[i].defined; }
    auto ref styles  () { return s[i].defined.styles; }
}

struct
_E {
    Defined   defined;
    Projected projected;

    struct
    Defined {
        IStyle[]    styles;  // loc, len, color
    }

    struct
    Projected {
        _Style.
          Projected style;
    }
}


//
struct
IE_Container {
    // defined
    IE[] s;
    // projected
    LL[] ll;

    auto ref content () { return s; }

    void
    opAssign (_Style b) {
        //
    }

    void
    opAssign (IStyle b) {
        //
    }
}

struct
Text {
    // defined
    char[] s;
    // projected
    LL[] rects;
}

struct
Text_Style {
    // defined
    char[]  char_s;   // same len
    Style[] style_s;  // 

    struct
    Style {
        // char style
        string color;
        string font;
        string char_len_x;
        string char_len_y;
        string char_bold;
        string char_italic;
    }
    // projected
    LL[] rects;
}
struct
Text_Style_Image {
    // defined
    IChar[]  char_s;   // same len
    IStyle[] style_s;  // 
    // projected
    LL[]     rects;

    this (string a) {
        static 
        if (is (typeof (IChar.i) == char)) {
            this.char_s         = cast (IChar[]) a.ptr[0..a.length];
            this.style_s.length = this.char_s.length;
        }
        else
            assert (0, "unsupported type");
    }

    void
    opAssign (Style style) {
        style_s[] = IStyle (style);
    }

    auto
    opSlice (size_t a, size_t b) {
        return Text_Style_Image_Slice (&this,a,b);
    }

    struct
    Text_Style_Image_Slice {
        Text_Style_Image* src;
        size_t a;
        size_t b;

        void
        opAssign (Style style) {
            (*src).style_s[a..b] = IStyle (style);
        }
    }

    struct
    IStyle {
        char i;
        //
        static Style[] s;

        this (Style b) {
            // find or create
            auto _i = s.countUntil (b);
            if (_i != -1) // found
                i = _i.to!(typeof(i));
            else {  // not found
                // create
                s ~= b;
                i = (s.length-1).to!(typeof(i));
            }
        }
    }

    struct
    Style {
        string type;               // char, image
        union {
            struct {
                // char style
                string char_color;
                string char_font;  // = image_set
                string char_len_x;
                string char_len_y;
                string char_bold;
                string char_italic;
            }
            struct {
                // image style
                string image_color;
                string image_set;  // = font
                string image_len_x;
                string image_len_y;
                string image_scale_keep_x;
                string image_scale_keep_y;
            }
        }
    }
}

struct
IChar {
    char i;
}

void
go (string args) {
    auto text = Text_Style_Image ("Hi!");

    text = Text_Style_Image.Style ("t", "white", "PT Caption.ttf", "16", "16", "false", "false");
    writeln (text);

    text = Text_Style_Image.Style ("t", "red", "PT Caption.ttf", "16", "16", "false", "false");
    writeln (text);

    text[1..2] = Text_Style_Image.Style ("t", "green", "PT Caption.ttf", "16", "16", "false", "false");
    writeln (text);

    //
    auto target = new Target (L ([640,480]));
    //Projector ().project (text,target);
}

//
//Defined defined;
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
    Defined.Flags flags;

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

struct
Color {
    Defined   defined;
    Projected projected;

    struct
    Defined {
        //
    }

    struct
    Projected {
        //
    }
}


// Style
//   defined
//     loc
//     len
//   projected
//     in to e.projected.style
//
// E
//   defined
//     styles[]
//   projected
//     style
//       loc
//       len


// Text
//   char[] s
//
// Text + Style
//   char[]  char_s
//   Style[] style_s
// Style
//   color
//   font
//   char_len_x
//   char_len_y
//   char_bold
//   char_italic
//
// Text + Style + Image
//   char[]  char_s
//   Style[] style_s
// Style
//   color
//   font
//   char_len_x
//   char_len_y
//   char_bold
//   char_italic
//                    char_s -> image_set[char_s] -> image
//   image_set = font
//   image_len_x
//   image_len_y
//   image_scale_keep_x
//   image_scale_keep_y
