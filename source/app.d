import std.stdio;
import e          : E;
import vf.located : Located,Located_Container_Args;
import vf.tree    : Tree;

alias ELocated_Container_Args = Located_Container_Args!E;
alias ELocatedTree = Tree!(Located!E);


void 
main (string[] args) {
    ELocatedTree root;

    writeln ("OK");
}

