#include "engine"

void main() {
    object oPC = GetPCSpeaker();
    float fDuration = GetLocalFloat(oPC, "wg_sp_veil_duration");
    int iBaseAppearance = GetAppearanceType(oPC);

    SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HALF_ORC);
    DelayCommand(fDuration, SetCreatureAppearanceType(oPC, iBaseAppearance));
}
