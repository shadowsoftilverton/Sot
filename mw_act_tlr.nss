//::///////////////////////////////////////////////
//:: BODY TAILOR: Widget
//::                    item activation
//:://////////////////////////////////////////////
/*
   this makes the targeted NPC start the body tailor
   conversation, so you can change its wings, tail,
   head, tattoos, eyes, phenotype, etc etc etc.

   body tailor must be installed (the conversation and scripts, at least)
   this script must be called from your modules onActivateItem script.
   this uses stale kvernes method.
*/
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//:://////////////////////////////////////////////

#include "uw_inc"

void main()
{
    object   oPC   = OBJECT_SELF;
    object   oTarget   = GetUtilityTarget(oPC);

    AssignCommand(oPC, ActionStartConversation(oTarget, "tlr_conv", TRUE, FALSE));

}

