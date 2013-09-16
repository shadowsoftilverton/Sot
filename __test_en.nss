#include "engine"

void main()
{
    object oPC = GetFirstPC();
    object oME = GetEnteringObject();

    SetLocalObject(oME, "TestObject", oPC);
}
