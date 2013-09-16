#include "engine"

#include "inc_areas"

#include "uw_inc"

void main()
{
     object oPC = OBJECT_SELF;
     object oArea = GetArea(oPC);

    CreateDMAreaInstance(oPC, oArea);
}
