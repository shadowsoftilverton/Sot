#include "engine"

void main() {
    object oPC = GetPCSpeaker();
    float fDuration = GetLocalFloat(oPC, "wg_sp_altself_duration");
    int iBaseAppearance = GetAppearanceType(oPC);

    SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_DWARF);
    DelayCommand(fDuration, SetCreatureAppearanceType(oPC, iBaseAppearance));
}
