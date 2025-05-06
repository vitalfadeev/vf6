module vf.tree;


struct
Container (T) {
    Contant!T[] s;
}

struct
Contant (T) {
    T a;
}

alias Tree (E) = Container!E;