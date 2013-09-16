#include "engine"

const float RESPAWN_TIMER_DEFAULT = 600.0;

void RespawnDoor(object oSelf)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oSelf) - GetCurrentHitPoints(oSelf)), oSelf);
    PlayAnimation(ANIMATION_DOOR_CLOSE);
}

void main()
{
    object oSelf = OBJECT_SELF;

    if(GetLocalInt(oSelf, "door_death_respawn")){
        SetIsDestroyable(FALSE);
        float fDelay = GetLocalFloat(oSelf, "door_death_respawn_timer");
        if(fDelay == 0.0) fDelay = RESPAWN_TIMER_DEFAULT;
        DelayCommand(fDelay, RespawnDoor(oSelf));
    }
}

