#include "engine"

void main()
{
    object oPC = GetPCSpeaker();

    SetAlignmentGoodEvil(oPC, 15);
    SetAlignmentLawChaos(oPC, 15);
}
