#include "engine"

void main()
{
    object oPC = GetPCSpeaker();

    SetAlignmentGoodEvil(oPC, 50);
    SetAlignmentLawChaos(oPC, 50);
}
