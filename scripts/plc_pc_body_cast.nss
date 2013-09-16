#include "engine"

#include "x2_inc_switches"

#include "inc_death"

void main(){
    object oBody = OBJECT_SELF;

    string sCharacter = GetLocalString(oBody, BODY_VAR_NAME);
    string sAccount = GetLocalString(oBody, BODY_VAR_ACCOUNT);

    object oCaster = GetLastSpellCaster();
    int nSpell = GetLastSpell();

    if(nSpell == SPELL_RAISE_DEAD){
        RevivePlayer(sCharacter, sAccount, GetLocation(oBody), 1);
    } else if(nSpell == SPELL_RESURRECTION){
        RevivePlayer(sCharacter, sAccount, GetLocation(oBody));
    }
}
