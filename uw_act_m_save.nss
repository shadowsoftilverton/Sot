#include "engine"

#include "inc_save"
#include "uw_inc"

void main()
{
    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);

    if(!GetIsDM(oPC)){
        SaveCharacter(oPC);
        FloatingTextStringOnCreature("Your character was saved successfully.", oPC, FALSE);
    } else {
        if(oPC == oTarget){
            SaveModule();
            FloatingTextStringOnCreature("Module was saved successfully.", oPC, FALSE);
        } else {
            string sName = ColorString(GetName(oTarget), 55, 255, 55);
            SaveCharacter(oTarget);
            FloatingTextStringOnCreature(sName + " was saved successfully.", oPC, FALSE);
        }
    }
}
