module e;

import vf.l  : L,LC;
import klass : Klass;


struct
E {
    bool    hidden;
    L       len;
    Klasses klasses;

    void
    add (E* b) {
        //
    }
}

struct
E_Container {
    E[] s;
}

alias iE = ushort;


struct
Klasses {
    Klass*[] s;
}
