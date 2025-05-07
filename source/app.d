import std.stdio;
import std.format;
import e          : E,E_Container;
import vf.l       : L,LC;
import vf.located : Located_Container,Located,Projector,Target;
import vf.tree    : Tree;


void 
main (string[] args) {
    auto e_container = E_Container ();
    auto e           = E ();

    e_container.s ~= e;

    auto target    = new Target (L ([100,100]));  // image 100x100
    auto projector = new Projector (target);
    auto located   = new Located (Located.Defined (LC(L(0),L(2)),LC(L(1),L(1))));  // loc,len (lu,100%)
    projector.project (located);

    writeln ("OK");
}
