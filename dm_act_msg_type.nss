#include "engine"

#include "nwnx_dmactions"

#include "inc_strings"

#include "dm_inc"

void main(){
    object oDM = OBJECT_SELF;

    if(DoISSToolLimiting(oDM)) return;

    object oTarget = GetDMActionTarget();

    int nType = GetDMActionIntParam();

    switch(nType){
        case DM_MSG_CHANGE_DIFFICULTY:
            PreventDMAction();

            ErrorMessage(oDM, "Dungeon Masters cannot adjust the difficulty of the server. This chage will not be reflected in-game.");
        break;

        case DM_MSG_GET_VAR:
        case DM_MSG_SET_VAR:
            PreventDMAction();

            ErrorMessage(oDM, "Dungeon Masters cannot get or set local variables.");
        break;

        case DM_MSG_JUMP_ALL_PLAYERS:
            PreventDMAction();

            ErrorMessage(oDM, "Dungeon Masters cannot jump all players.");
        break;

        case DM_MSG_MODIFY_STATS:
            /*if(GetIsPC(oTarget) && !GetIsDM(oTarget)){
                PreventDMAction();

                ErrorMessage("Dungeon Masters cannot modify PC stats.");
            }*/
        break;
    }
}
