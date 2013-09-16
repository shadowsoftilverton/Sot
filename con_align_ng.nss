#include "engine"

void main()
{
    object oPC = GetPCSpeaker();

    SetAlignmentGoodEvil(oPC, 85);
    SetAlignmentLawChaos(oPC, 50);
}
