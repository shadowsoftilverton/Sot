#include "engine"

void main()
{
    object oExit = GetExitingObject();
    DeleteLocalInt(oExit, "HorseParking");
    FloatingTextStringOnCreature("Leaving mount safe zone.", oExit, FALSE);

    if(GetStringLeft(GetResRef(oExit), 4) == "hrs_")
    {
        SetImmortal(oExit, FALSE);
    }
}
