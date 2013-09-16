#include "engine"

#include "inc_conversation"

int StartingConditional(){
    return !GetIsConversationInputValid(GetPCSpeaker());
}
