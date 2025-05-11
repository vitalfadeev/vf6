module e;

import vf.l  : L,LC;
import klass : Klass;


struct
E {
    // Located
    bool    hidden;
    L       len;
    Klasses klasses;
}

struct
E_Container {
    // Located
    E[] s;
    Klasses klasses;

    void
    add (E* b) {
        //
    }
}

alias iE = ushort;


struct
Klasses {
    Klass*[] s;

    void
    opOpAssign (string op : "~") (Klass* b) {
        //
    }
}
