module vf.tree;


struct
Container (T) {
    Contant!T[] s2;
}

struct
Contant (T) {
    T a;
}

alias Tree (T) = Container!(T);

auto
WalkChilds (Container) (Container* con) {
    return _WalkChilds!Container (con,&skip_hidden);
}
struct
_WalkChilds (Container,T) {
    Container*     con;
    Skip!Container skip;

    int
    opApply (int delegate (ref Contant c) dg) {
        import std.range : popBack;

        foreach (ref _c; con.s)
            if (!skip (_c))
            if (auto result = dg (_c))
                return result;

        return 0;
    }
}

bool 
skip_hidden (T) (T* a) {
    return a.hidden;
}

alias Skip (T) = bool function (Container* a);
