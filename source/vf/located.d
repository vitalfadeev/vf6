module vf.located;

import vf.int32x2 : int32x2;
import vf.tree : Tree;


struct
Located (E) {
    LC          origin;    // projected = origin.of (project_image_len)
    bool[N]     way;       // [0,0] - +x,+y, [1,1] - -x,-y, [0,1] - +x,-y
    LC          len;
    bool[N]     expand_len;
    //
    Projected   projected;  // filled in draw
    //
    E           e;
}

alias ELocated = Located!E;

alias E = int;

struct 
Projected {
    L loc;
    L len;
}

char      [N_Childs] childs;
Projected [N_Childs] uses;

struct 
Located_Container_Args (E) {
    L            len;
    bool         overflow_wrap;
    ELocatedTree s;
}
alias ELocated_Container_Args = Located_Container_Args!E;
alias ELocatedTree = Tree!ELocated;

struct
LC {                   // SIMD optimized
    L len;             // length   : 0 50 100
    L cap = L([1,1]);  // capacity : 1 2 100

    L
    project (L target_l) {
        return target_l.muldiv (len,cap);
    }
}

alias L = int32x2;

enum N_Childs = 0;
enum N        = 2; // X,Y


//
void
update (ELocated* a, ELocated_Container_Args* args) {
    //
}

void
draw (Renderer* renderer, ELocated* a) {
    // calc projected
    a.projected.len = a.origin.project (renderer.target_len);
}

struct
Renderer {
    L target_len;
}
