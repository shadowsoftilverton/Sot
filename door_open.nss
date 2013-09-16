#include "engine"

void main()
{
    object oDoor = OBJECT_SELF;

    int iTimerClose = GetLocalInt(oDoor, "timer_close");

    if(iTimerClose > 0){
        DelayCommand(IntToFloat(iTimerClose), ActionCloseDoor(oDoor));
    }
}
