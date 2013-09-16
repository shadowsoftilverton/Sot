#include "engine"

#include "zzdlg_main_inc"
#include "zzdlg_tools_inc"

void main()
{
    object oPC = GetPCSpeaker();

    _dlgStart(oPC, GetModule(), "dlg_spellbook", TRUE, TRUE, TRUE);
}
