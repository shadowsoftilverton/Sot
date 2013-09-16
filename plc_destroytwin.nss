#include "engine"

#include "inc_debug"

void main()
{
    string sTwin = GetLocalString(OBJECT_SELF, "transition_tag");

    object oTwin = GetObjectByTag(sTwin);

    SendMessageToDevelopers("Attempting to destroy twin: " + GetTag(oTwin));

    ExecuteScript("gen_destroy_self", oTwin);
}
