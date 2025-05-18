module vf.int8x4.sse_4_2;


version (int8x4_SSE_4_2):
alias int8 = ubyte;

// SSE 4.2
struct
int8x4 {
    int8[4] s;  // signed integer. XY coordinates. -32768..+32767

    //int8x4 add    (int8x4 b)           { return _add (this,b); }
    //int8x4 sub    (int8x4 b)           { return _sub (this,b); }
    //int8x4 mul    (int8x4 b)           { return _mul (this,b); }
    //int8x4 div    (int8x4 b)           { return _div (this,b); }
    //int8x4 muladd (int8x4 b, int8x4 c) { return (this*b)+c; }
    //int8x4 mulsub (int8x4 b, int8x4 c) { return (this*b)-c; }
    //int8x4 muldiv (int8x4 b, int8x4 c) { return _muldiv (this,b,c); }
    //int8x4 min    (int8x4 b)           { return _min (this,b); }
    //int8x4 max    (int8x4 b)           { return _max (this,b); }
    //int8x4 abs    ()                   { return _abs (this);   }

    //int8x4 opBinary (string op : "+") (int8x4 b) { return add (b); }
    //int8x4 opBinary (string op : "-") (int8x4 b) { return sub (b); }
    //int8x4 opBinary (string op : "*") (int8x4 b) { return mul (b); }
    //int8x4 opBinary (string op : "/") (int8x4 b) { return div (b); }

    //auto ref opIndex (size_t i) { return s[i]; }

    this (uint b) {
        union _ {
            uint    a;
            int8[4] s;
        }
        this.s = _(b).s;
    }

    Style_Color
    to_console_color () {
        Style_Color style_color;

        auto r = s[3];
        auto g = s[2];
        auto b = s[1];

        bool r_bit = r > 0;
        bool g_bit = g > 0;
        bool b_bit = b > 0;

        bool r_bit_dark = r < 128;
        bool g_bit_dark = g < 128;
        bool b_bit_dark = b < 128;

        if ((r_bit && r_bit_dark) || (g_bit && g_bit_dark) || (b_bit && b_bit_dark))
            style_color.style = 2;

        style_color.color = (b_bit << 2) + (g_bit << 1) + (r_bit);

        return style_color;  // [style,color]
    }

    struct
    Style_Color {
        ubyte style;
        ubyte color;
    }
}

//pragma (inline,true)
//int8x4 
//_add (int8x4 a, int8x4 b) {
//    return int8x4 ([a.s[0] + b.s[0], a.s[1] + b.s[1]]);
//}

//pragma (inline,true)
//int8x4 
//_sub (int8x4 a, int8x4 b) {
//    return int8x4 ([a.s[0] - b.s[0], a.s[1] - b.s[1]]);
//}

//pragma (inline,true)
//int8x4 
//_mul (int8x4 a, int8x4 b) {
//    return int8x4 ([a.s[0] * b.s[0], a.s[1] * b.s[1]]);
//}

//pragma (inline,true)
//int8x4 
//_div (int8x4 a, int8x4 b) {
//    return int8x4 ([a.s[0] / b.s[0], a.s[1] / b.s[1]]);
//}

//pragma (inline,true)
//int8x4 
//_muldiv (int8x4 a, int8x4 b, int8x4 c) {
//    // load a,b
//    //   mov q        xmm1, &a               // SSE2
//    //   mov q        xmm2, &b               // SSE2
//    // convert to float
//    //   cvt dq 2 ps  xmm1, xmm1             // SSE2
//    //   cvt dq 2 ps  xmm2, xmm2             // SSE2
//    // mul
//    //   mulps        xmm1, xmm2             // SSE
//    // load c, convert to float
//    //   mov q        xmm2, &c               // SSE2
//    //   cvt dq 2 ps  xmm2, xmm2             // SSE2
//    // div
//    //   div ps       xmm1, xmm2             // SSE
//    // convert float to i32, store RESULT
//    //   cvt ps 2 dq  xmm1, xmm1             // SSE2
//    //   mov q        &RESULT, xmm1          // SSE2
//    return int8x4 ([
//        (a.s[0] * b.s[0]) / c.s[0], 
//        (a.s[1] * b.s[1]) / c.s[1]
//    ]);
//}

//pragma (inline,true)
//int8x4 
//_min (int8x4 a, int8x4 b) {
//    return int8x4 ([
//        (a.s[0] < b.s[0]) ? a.s[0] : b.s[0], 
//        (a.s[1] < b.s[1]) ? a.s[1] : b.s[1]
//    ]);
//}

//pragma (inline,true)
//int8x4 
//_max (int8x4 a, int8x4 b) {
//    return int8x4 ([
//        (a.s[0] > b.s[0]) ? a.s[0] : b.s[0], 
//        (a.s[1] > b.s[1]) ? a.s[1] : b.s[1]
//    ]);
//}

//pragma (inline,true)
//int8x4 
//_abs (int8x4 a) {
//    return int8x4 ([
//        (a.s[0] < 0) ? -a.s[0] : a.s[0], 
//        (a.s[1] < 0) ? -a.s[1] : a.s[1]
//    ]);
//}

// SSE
//   XMM0  int64x2
//   XMM1  int64x2
//   XMM2  int64x2
//   XMM3  int64x2
//   XMM4  int64x2
//   XMM5  int64x2
//   XMM6  int64x2
//   XMM7  int64x2

//       [S P] S
// ADD    S    S
// SUB    S    S
// MUL    S    S
// DIV    S    S
// RCP    S    S
// MAX    S    S
// MIN    S    S
// SQRT   S    S
// RSQRT  S    S
//
// MOV     S  S
// MOV A   P  S
// MOV U   P  S
// MOV L   P  S
// MOV H   P  S
// MOV LH  P  S
// MOV HL  P  S
//
// CMP     S S
// COM  I  S S
// UCO  MI S S
// CMP     P S
//
// SHUF    P S
// UNPCKH  P S
// UNPCKL  P S
//
// CVT  S I 2 S S
// CVT  S S 2 S I
// CVTT S S 2 S I
//
// CVT  P I 2 P S
// CVT  P S 2 P I
// CVTT P S 2 P I
//
// AND  P S
// OR   P S
// XOR  P S
// ANDN P S
//
///////////////////////////////
// INTEGER
///////////////////////////////
// P MUL HU W
// P SAD B  W
// P AVG    B
// P AVG    W
// P MAX U  B
// P MIN U  B
// P MAX S  W
// P MIN S  W
//
// P EXT RW
// P INS RW
//
// P MOV MSK B
// P SHUF    W
//
// LD MX CSR
// ST MX CSR
//
// MOV NT Q
// MOV NT PS
// MASK MOV Q
// P RE FETCH 0
// P RE FETCH 1
// P RE FETCH 2
// P RE FETCH NTA
// SFENCE

// SSE 2
// p mul u d q
//
// SSE 4.1
// p mul l d

