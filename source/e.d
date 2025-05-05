struct
E {
    //
}

struct
Located (E,N) {
    LC[N]       origin;  // projected = origin.of (pare_rect_len)
    bool[N]     way;     // [0,0] - +x,+y, [1,1] - -x,-y, [0,1] - +x,-y
    LC[N]       len;
    bool[N]     expand;
    //
    Projected!N projected;
    //
    E           e;
}


struct 
Projected (N) {
    L[N] loc;
    L[N] len;
}

struct 
ProLocLen (N) {
    L[N] loc;
    L[N] len;
}

char          [N_Childs] childs;
ProjectdLocLen[N_Childs] uses;

Message on_click;
// Message -> Events -> Message_Action[Message] -> Action
struct
Message_Action {
    Action action0;  // Message 0
    Action action1;  // Message 1
    Action action2;  // Message 2
}

struct 
Located_Container (E,N) {
    L[N]            len;
    Located!(E,N)[] s;
    bool            overflow_wrap;
}

struct 
LC {
    L len;      // length   : 0 50 100
    L cap = 1;  // capacity : 100

    auto
    of (L l) {
        return 
            (cap) ?
                l * len / cap : 
                0;
    }
}

alias L    = int;  // length
