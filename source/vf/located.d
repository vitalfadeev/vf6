module vf.located;

import vf.l : L,LC;


struct
Located_Container {  // extend E resources to Located_E resources
    Defined   defined;
    Projected projected;
    Located[] s;

    struct 
    Defined {
        LC    loc;
        LC    len;
        Flags flags;
    }
    struct 
    Projected {
        L     loc;
        L     len;
    }
    struct
    Flags {
        ubyte s;

        enum 
        Mask : typeof (s) {
            overflow_wrap = 0b0000_0001,
            way_x         = 0b0000_0010,
            way_y         = 0b0000_0100,
        }

        auto overflow_wrap () { return (s & Mask.overflow_wrap); }
        auto way_x         () { return (s & Mask.way_x); }
        auto way_y         () { return (s & Mask.way_y); }

        void overflow_wrap (bool b) { if (b) s |= Mask.overflow_wrap; else s &= !Mask.overflow_wrap ; }
        void way_x         (bool b) { if (b) s |= Mask.way_x;         else s &= !Mask.way_x ; }
        void way_y         (bool b) { if (b) s |= Mask.way_y;         else s &= !Mask.way_y ; }
    }

    struct
    Located {
        Defined   defined;
        Projected projected;

        struct 
        Defined {
            LC    loc;
            LC    len;
        }
        struct 
        Projected {
            L     loc;
            L     len;
        }
    }
    alias iLocated = ushort;
}


void
go () {
    //
}

void
draw (Located) (Renderer* renderer, Located* located) {
    // calc projected
    located.projected.len = located.defined.len.project (renderer.target.len);
}

struct
Renderer {
    Target target;

    struct
    Target {
        L len;
    }
}
