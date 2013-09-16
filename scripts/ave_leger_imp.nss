#include "engine"

void main()
{
    location lTarget = GetSpellTargetLocation();
    object oCaster = OBJECT_SELF;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_ITEM | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_PLACEABLE);
    int iType=GetObjectType(oTarget);
    switch(iType)
    {
        case OBJECT_TYPE_CREATURE:
        break;

        case OBJECT_TYPE_DOOR:
        if(GetIsTrapped(oTarget) && GetTrapDetectedBy(oTarget, oCaster) && GetTrapDisarmable(oTarget))
        {
             if(GetIsSkillSuccessful(oCaster, SKILL_DISABLE_TRAP, GetTrapDisarmDC(oTarget)))
             {
                 SendMessageToPC(oCaster,"Disable Trap Successful!");
                 SetTrapDisabled(oTarget);
             }
             else
             {
                 SendMessageToPC(oCaster,"Disable Trap Failed");
             }
        }
        else if(GetLocked(oTarget))
        {
            if(GetLockKeyRequired(oTarget))    //Requires a key?
            {
                SendMessageToPC(oCaster,"This Lock Requires a Specific Key");
            }
            else
            {
                if(GetIsSkillSuccessful(oCaster, SKILL_OPEN_LOCK, GetLockUnlockDC(oTarget)))
                {
                    SetLocked(oTarget, FALSE);
                    SendMessageToPC(oCaster,"Open Lock Successful!");
                }
                else
                {
                    SendMessageToPC(oCaster,"Open lock failed");
                }
            }
        }
        else
        {
           SendMessageToPC(oCaster,"Object has no lock or detected trap");
        }
        break;

        case OBJECT_TYPE_PLACEABLE:
        if(GetIsTrapped(oTarget) && GetTrapDetectedBy(oTarget, oCaster) && GetTrapDisarmable(oTarget))
        {
             if(GetIsSkillSuccessful(oCaster, SKILL_DISABLE_TRAP, GetTrapDisarmDC(oTarget)))
             {
                 SendMessageToPC(oCaster,"Disable Trap Successful!");
                 SetTrapDisabled(oTarget);
             }
             else
             {
                 SendMessageToPC(oCaster,"Disable Trap Failed");
             }
        }
        else if(GetLocked(oTarget))
        {
            if(GetLockKeyRequired(oTarget))    //Requires a key?
            {
                SendMessageToPC(oCaster,"This Lock Requires a Specific Key");
            }
            else
            {
                if(GetIsSkillSuccessful(oCaster, SKILL_OPEN_LOCK, GetLockUnlockDC(oTarget)))
                {
                    SetLocked(oTarget, FALSE);
                    SendMessageToPC(oCaster,"Open Lock Successful!");
                }
                else
                {
                    SendMessageToPC(oCaster,"Open lock failed");
                }
            }
        }
        else
        {
           SendMessageToPC(oCaster,"Object has no lock or detected trap");
        }
        break;
        case OBJECT_TYPE_ITEM:
        //if(GetWeight(oTarget)<20);
        //{//If the object is less than 2.0 lbs
            //if(Std_GetIsSkillSuccessful(oCaster, SKILL_PICK_POCKET, 10))
            //{
                //SendMessageToPC(oCaster,"Sleight of Hand Successful!");
                //ActionGiveItem(oTarget,oCaster);
            //}
            //else
            //{
                //SendMessageToPC(oCaster,"Sleight of Hand Failed");
            //}
        //}
        //break;
        case OBJECT_TYPE_TRIGGER:
        break;
        default:
        //object InvisTrapFinder=CreateObject(OBJECT_TYPE_PLACEABLE,"ave_invis_1",lTarget);
        oTarget=GetNearestTrapToObject(oCaster,FALSE);
        //DestroyObject(InvisTrapFinder);
        if(Std_GetIsSkillSuccessful(oCaster, SKILL_DISABLE_TRAP, GetTrapDisarmDC(oTarget)))
        {
            SendMessageToPC(oCaster,"Disable Trap Successful!");
            SetTrapDisabled(oTarget);
        }
        else
        {
            SendMessageToPC(oCaster,"Disable Trap Failed");
        }
        break;
    }

}
