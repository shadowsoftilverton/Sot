//Opens the door in the Demesne of the Damned, Where Withered Bones Bleach
//that leads down, if one gives it the heart of the guardian
//by LostInSpace

void main()
{
    //Check if it has the heart, otherwise, abort
    if (GetItemPossessedBy(OBJECT_SELF, "lis_ddhrt")== OBJECT_INVALID)
    {return;}

    //destroy the heart and open the door
    DestroyObject(GetItemPossessedBy(OBJECT_SELF, "lis_ddhrt"));
    object oDoor = GetObjectByTag("door_lis_ddcr3e");
    FloatingTextStringOnCreature("[As you put the large gem in the jar, it begins instantly glowing, spinning and turning as if trying to break free...]", GetLastClosedBy());
    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL), GetLocation(OBJECT_SELF)));
    DelayCommand(12.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWSTUN), GetLocation(GetObjectByTag("door_lis_ddcr3e"))));
    DelayCommand(14.0, AssignCommand(oDoor,ActionOpenDoor(oDoor)));
    SetLocked(oDoor,FALSE);
    DelayCommand(3600.0,AssignCommand(oDoor,ActionCloseDoor(oDoor)));;
    DelayCommand(3601.0,AssignCommand(oDoor,ActionLockObject(oDoor)));
}

