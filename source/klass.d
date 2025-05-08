module klass;

import vf.l : L,LC;


struct
Klass {
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

