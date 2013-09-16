#include "engine"

void Etherize(object oHider1, object oHider2, object oHider3)
{
    effect eHide = EffectEthereal();

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHide, oHider1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHide, oHider2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHide, oHider3);
}

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsObjectValid(oPC))
    {
        SendMessageToPC(oPC, "You find yourself in a dark, musty cavern. The air is thick and smells strongly of sewage or something like it. The flame on any torches or weapons burn much brighter than before.");
    }

    object oList0 = GetObjectByTag("ufo_gld_lstn001");

    if(oList0 == OBJECT_INVALID)
    {
        object oWP1 = GetObjectByTag("WP_SPN_LISTEN001");
        object oWP2 = GetObjectByTag("WP_SPN_LISTEN002");
        object oWP3 = GetObjectByTag("WP_SPN_LISTEN003");
        location lWP1 = GetLocation(oWP1);
        location lWP2 = GetLocation(oWP2);
        location lWP3 = GetLocation(oWP3);

        CreateObject(OBJECT_TYPE_CREATURE, "ufo_gld_lstn001", lWP1, FALSE, "ufo_gld_lstn001");
        CreateObject(OBJECT_TYPE_CREATURE, "ufo_gld_lstn001", lWP2, FALSE, "ufo_gld_lstn002");
        CreateObject(OBJECT_TYPE_CREATURE, "ufo_gld_lstn001", lWP3, FALSE, "ufo_gld_lstn003");

        object oList1 = GetObjectByTag("ufo_gld_lstn001");
        object oList2 = GetObjectByTag("ufo_gld_lstn002");
        object oList3 = GetObjectByTag("ufo_gld_lstn003");

        DelayCommand(1.0f, Etherize(oList1, oList2, oList3));
    }
}
