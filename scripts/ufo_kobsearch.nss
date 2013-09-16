#include "engine"

void main()
{
    object oPC = GetEnteringObject();

        int nSearch = Std_GetSkillRank(14, oPC, FALSE); //Search
        int nDung = Std_GetSkillRank(38, oPC, FALSE); //K: Dungeoneering
        int nDCS = 23;
        int nDCD = 28;
        int nRolled = GetLocalInt(oPC, "ufo_kobsearch");

        if(nRolled != 0)
        {
            return;
        }

        if(nSearch >= nDCS)
        {
            if(nDung >= nDCD)
            {
                SendMessageToPC(oPC, "The pale patches on the ground, hidden by the thick bramble, are almost certainly traps of some kind, embedded in the stone itself.");
                GiveXPToCreature(oPC, 80);
                SetLocalInt(oPC, "ufo_kobsearch", 1);
            }

            else
            {
                SendMessageToPC(oPC, "Something seems off about some pale patches on the ground, hidden beneath the thick bramble.");
                SetLocalInt(oPC, "ufo_kobsearch", 1);
            }
        }

        else
        {
            SendMessageToPC(oPC, "Thick brambles cover the ground ahead making passage tiresome and annoying.");
            SetLocalInt(oPC, "ufo_kobsearch", 1);
        }
}
