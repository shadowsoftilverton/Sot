#include "engine"

#include "nwnx_dmactions"

#include "inc_iss"
#include "inc_strings"

int DoISSToolLimiting(object oDM){
    // This is a dirty hack, but DMs are automatically stuck in ooc_entry to
    // minimize damage, regardless. If they escaped, they used DM tools -- they
    // must've been verified.
    if(GetTag(GetArea(oDM)) != "ooc_entry") return TRUE;

    // Since DMs can't possess things
    if(!GetIsISSVerified(oDM) || !GetIsISSEnabled(oDM)){
        PreventDMAction();

        ErrorMessage(oDM, ISS_MSG_DM_MUST_ENABLE);

        return TRUE;
    }

    return FALSE;
}
