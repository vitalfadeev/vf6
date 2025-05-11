module vf.l;

import vf.int32x2 : int32x2;


struct
LC {                   // SIMD optimized
    L len;             // length   : 0 50 100
    L cap = L([1,1]);  // capacity : 1 2 100

    L
    project (L target_l) {
        return target_l.muldiv (len,cap);
    }
}

struct
LL {
    L loc;
    L len;
}

alias L = int32x2;
