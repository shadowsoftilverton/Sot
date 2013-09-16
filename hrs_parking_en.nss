#include "engine"

void main()
{
    object oEnter = GetEnteringObject();
    SetLocalInt(oEnter, "HorseParking", 1);
    FloatingTextStringOnCreature("Entering mount safe zone.", oEnter, FALSE);

    if(GetStringLeft(GetResRef(oEnter), 4) == "hrs_")
    {
        SetImmortal(oEnter, TRUE);
    }
}
