//For NPCs that should be sitting either OnSpawn or OnConversation, or both.
//The NPC must have a dsignated chair for the automated seating to occur: on the NPC a String variable
//named Seat with a value that is the same as the Tag of its chair should be stored. The NPC will only
//go to the chair if they are in the same area and within 10 meters of each other.
//
//When using with OnConversation, there should be a String variable on the NPC named Convo with a value
//that is the name of the NPC's conversation.

//#include "engine"

void main()
{
    object oSitter = OBJECT_SELF;
    string sNPCTag = GetLocalString(oSitter, "Seat");
    object oChair = GetObjectByTag(sNPCTag);

    object oA1 = GetArea(oSitter);
    object oA2 = GetArea(oChair);


    if(oA1 == oA2)
    {
        float fDist = GetDistanceBetween(oSitter, oChair);

        if(fDist <= 10.0f)
        {
            string sNPCCon = GetLocalString(oSitter, "Convo");
            float fOrient = GetFacing(oChair);

            ActionMoveToObject(oChair, FALSE, 1.5f);
            ClearAllActions(TRUE);
            BeginConversation(sNPCCon);
            SetFacing(fOrient);
            ActionSit(oChair);
        }
    }
}
