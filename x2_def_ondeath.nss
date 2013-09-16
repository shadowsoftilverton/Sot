//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

#include "ave_inc_rogue"

void main()
{
    object oDead=OBJECT_SELF;
    if(GetLocalInt(oDead,"ave_decoy")==1) DecoyBlast(oDead);
    ExecuteScript("nw_c2_default7", oDead);
}
