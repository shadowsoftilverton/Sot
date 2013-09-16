#include "engine"

#include "nwnx_events"

#include "inc_iss"

void main()
{
    object oFamiliar = GetEventTarget();

    SetIsISSVerified(oFamiliar, TRUE);
}
