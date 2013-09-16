#include "engine"

#include "inc_areas"

#include "inc_conversation"

void main()
{
    object oPC = OBJECT_SELF;
    object oArea = GetArea(oPC);

    string sName = GetConversationInput(oPC);

    SetAreaName(oArea, sName);
}
