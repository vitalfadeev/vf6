module vf.message_action;


// Message -> Events -> Message_Action[Message] -> Action
struct
Message_Action {
    Action action0;  // Message 0
    Action action1;  // Message 1
    Action action2;  // Message 2
}

struct
Action {
    //
}

Message on_click; 

alias Message = int;
