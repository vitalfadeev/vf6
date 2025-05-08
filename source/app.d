import std.stdio;
import std.format;
import e          : E,E_Container;
import klass      : Klass;
import vf.l       : L,LC;
import vf.located : Container,Located,Projector,Target;
import vf.tree    : Tree;


void 
main (string[] args) {
    import vf.located;
    vf.located.go ();
    writeln ("OK");
}

void
test_3 () {
    auto e_root      = new E ();

    auto e_rect_ul_1 = new E ();
    auto e_rect_ul_2 = new E ();
    auto e_rect_ul_3 = new E ();

    auto e_rect_uc_1 = new E ();
    auto e_rect_uc_2 = new E ();
    auto e_rect_uc_3 = new E ();

    auto e_rect_ur_1 = new E ();
    auto e_rect_ur_2 = new E ();
    auto e_rect_ur_3 = new E ();

    e_root.add (e_rect_ul_1);
    e_root.add (e_rect_ul_2);
    e_root.add (e_rect_ul_3);
    e_root.add (e_rect_uc_1);
    e_root.add (e_rect_uc_2);
    e_root.add (e_rect_uc_3);
    e_root.add (e_rect_ur_1);
    e_root.add (e_rect_ur_2);
    e_root.add (e_rect_ur_3);

    //
    auto klass_root = new Klass ();
    with (klass_root) {
        defined.loc = "cc";
        defined.len = "640 480";
    }

    auto klass_rect = new Klass ();
    with (klass_rect) {
        defined.len = "64 64";
    }

    auto klass_ul   = new Klass ();
    with (klass_rect) {
        defined.loc = "ul";
        defined.way = "rd";
    }

    auto klass_uc   = new Klass ();
    with (klass_rect) {
        defined.loc = "uc";
        defined.way = "rd";
    }

    auto klass_ur   = new Klass ();
    with (klass_rect) {
        defined.loc = "ur";
        defined.way = "ld";
    }

    //

}
