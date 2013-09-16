#include "engine"
#include "ave_inc_duration"
#include "uw_inc"
#include "inc_classes"
#include "inc_henchmen"
#include "ave_inc_event"

void main()
{
    object oPC = GetLastPCRested();
    int nRestEvent = GetLastRestEventType();

    switch(nRestEvent){
        case REST_EVENTTYPE_REST_STARTED:
            if(!GetLocalInt(oPC, "REST_ENABLED")){
                AssignCommand(oPC, ClearAllActions());

                SendUtilityErrorMessageToPC(oPC, "You cannot rest here.");
            }

            DoRecoverWildshape(oPC);
    }
    DelayCommand(0.1,DecrementRemainingFeatUses(oPC,ACTIVE_DURATION_FEAT));
    SetLocalInt(oPC,"ave_duration",-1);
    DoRogueStuff(oPC);
    //REST_EVENTTYPE_REST_STARTED
    //REST_EVENTTYPE_REST_FINISHED
    //REST_EVENTTYPE_REST_CANCELLED

    //Removing custom summons.
    int nSummon = 1;
    object oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nSummon);
    effect eUnsummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2, FALSE);
    location lSummon;

    while(GetIsSummon(oSummon) == TRUE)
    {
        lSummon = GetLocation(oSummon);
        DestroyHenchman(oPC, oSummon);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnsummon, lSummon);

        nSummon ++;
        oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nSummon);
    }
}
