import vf.l : L,LC;

struct
Text_Container {
    Defined   defined;
    Projected projected;
    string    source;
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
    }

    struct
    Located {
        Projected projected;

        struct 
        Projected {
            L     loc;
            L     len;
        }
    }
}
