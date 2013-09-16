#include "engine"

#include "nwnx_events"

void main()
{
    if(GetEventSubType() == ACTION_MODE_STEALTH){
        int iStealth = GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH);

        // We're currently in stealth mode, so we must be leaving it.
        if(iStealth){
            SendMessageToPC(OBJECT_SELF, "Leaving stealth mode.");

            // Disable stealth.
            SetLocalInt(OBJECT_SELF, "STEALTH_DISABLED", TRUE);

            DelayCommand(9.0, DeleteLocalInt(OBJECT_SELF, "STEALTH_DISABLED"));
        } else {
            // If stealth mode is supposed to be disabled, yell at the player.
            if(GetLocalInt(OBJECT_SELF, "STEALTH_DISABLED")){
                SendMessageToPC(OBJECT_SELF, "You cannot enter stealth mode again so soon.");
                BypassEvent();
                return;
            }

            SendMessageToPC(OBJECT_SELF, "Entering stealth mode.");
        }
    }
}
