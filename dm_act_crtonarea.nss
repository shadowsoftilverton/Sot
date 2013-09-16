#include "engine"

#include "nwnx_dmactions"

#include "inc_iss"

#include "dm_inc"


void main()
{
    object oDM = OBJECT_SELF;

    if(DoISSToolLimiting(oDM)) return;
}
