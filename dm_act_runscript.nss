#include "engine"

#include "nwnx_dmactions"

#include "inc_strings"

#include "dm_inc"

void main(){
    object oDM = OBJECT_SELF;

    PreventDMAction();

    ErrorMessage(oDM, "Dungeon Masters cannot directly execute scripts.");
}
