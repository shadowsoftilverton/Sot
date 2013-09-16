#include "engine"

#include "x2_inc_switches"

#include "inc_death"

void main(){
    int nEvent = GetUserDefinedItemEventNumber();

    switch(nEvent){
        case X2_ITEM_EVENT_ACQUIRE:
        {
            object oItem = GetModuleItemAcquired();
            object oPC = GetPCFromPlayerName(GetLocalString(oItem, BODY_VAR_NAME), GetLocalString(oItem, BODY_VAR_ACCOUNT));

            if(GetIsObjectValid(oPC))
                FloatingTextStringOnCreature("* You feel yourself being picked from the ground. *", oPC, FALSE);
        }

        case X2_ITEM_EVENT_UNACQUIRE:
        {
            object oItem = GetModuleItemLost();
            object oPC = GetPCFromPlayerName(GetLocalString(oItem, BODY_VAR_NAME), GetLocalString(oItem, BODY_VAR_ACCOUNT));

            if(GetIsObjectValid(oPC))
                FloatingTextStringOnCreature("* You feel yourself being dropped down to the ground. *", oPC, FALSE);
        }

        case X2_ITEM_EVENT_SPELLCAST_AT:
        {
            object oItem = GetSpellTargetObject();
            object oCaster = OBJECT_SELF;

            string sCharacter = GetLocalString(oItem, BODY_VAR_NAME);
            string sAccount = GetLocalString(oItem, BODY_VAR_ACCOUNT);

            int nSpell = GetSpellId();

            location lRevive = GetIsObjectValid(GetItemPossessor(oItem))
                             ? GetLocation(oCaster) : GetLocation(oItem);

            if(nSpell == SPELL_RAISE_DEAD){
                RevivePlayer(sCharacter, sAccount, lRevive, 1);
            } else if(nSpell == SPELL_RESURRECTION){
                RevivePlayer(sCharacter, sAccount, lRevive);
            }
        }
        break;
    }
}
