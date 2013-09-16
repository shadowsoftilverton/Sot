//For the OnOpened script of a placeable with a container.

#include "engine"

void main()
{
    int nReset = GetLocalInt(OBJECT_SELF, "IsPicked");

    if(nReset = 0)
    {
        object oPC = GetLastDisturbed();
        string sPC = GetName(oPC);
        string sResRef;
        int nRoll = d100();

        if(nRoll >= 96)
        {
            sResRef = "ufo_ant_vermice";
        }

        else if(nRoll >= 81 && nRoll <= 95)
        {
            sResRef = "ufo_ant_inocybe";
        }

        else if(nRoll <= 80)
        {
            sResRef = "ufo_ant_cantrel";
        }

        CreateItemOnObject(sResRef, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "IsPicked", 1);
        DelayCommand(2400.0f, SetLocalInt(OBJECT_SELF, "IsPicked", 0));
    }
}
