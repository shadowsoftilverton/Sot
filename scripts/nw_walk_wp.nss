#include "engine"

#include "NW_I0_GENERIC"

#include "inc_conversation"

void main()
{
    ResetConversationInput(GetPCSpeaker());

    WalkWayPoints();
}
