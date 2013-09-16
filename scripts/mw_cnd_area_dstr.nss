#include "engine"

#include "inc_areas"

int StartingConditional()
{
    object oPC = OBJECT_SELF;
    object oArea = GetArea(oPC);

    return GetLocalInt(oArea, AREA_LV_IS_INSTANCED);
}
