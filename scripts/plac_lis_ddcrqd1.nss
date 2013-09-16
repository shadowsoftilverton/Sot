void main()
{
    object oChest;
    object oDoor;
    object oTarget;
    object oPC=GetLastClosedBy();

//If already open piss off
    oDoor=GetNearestObjectByTag("door_ddcr1qd1");
    if (GetIsOpen(oDoor)==TRUE)
    {return;}

//Check if it has the rose
    oChest=GetObjectByTag("plc_lis_ddgrhnds");
    if (GetItemPossessedBy(oChest, "lis_ddflwr")== OBJECT_INVALID)
    {return;}

//Check gold in both eyes
    oChest=GetObjectByTag("plc_lis_ddgreyel");
    if (GetGold(oChest)== 0)
    {return;}

    oChest=GetObjectByTag("plc_lis_ddgreyer");
    if (GetGold(oChest)== 0)
    {return;}

//Open the door, and lock it after a short delay. Some extra delay for suspension, and a little VFX
    FloatingTextStringOnCreature("[The statue on the stone slab, as it seems, gives off a small, relieved sigh as the rose and coins begin to turn into stone...]", oPC);
    DelayCommand(12.0, ActionOpenDoor(oDoor));
    DelayCommand(600.0, ActionCloseDoor(oDoor));
    DelayCommand(601.0, SetLocked(oDoor, TRUE));

    DelayCommand(12.0, ActionOpenDoor(GetObjectByTag("door_lis_ddcr2e1")));
    DelayCommand(600.0, ActionCloseDoor(GetObjectByTag("door_lis_ddcr2e1")));
    DelayCommand(601.0, SetLocked(GetObjectByTag("door_lis_ddcr2e1"), TRUE));

    DelayCommand(12.0, ActionOpenDoor(GetObjectByTag("door_lis_ddcr2e2")));
    DelayCommand(600.0, ActionCloseDoor(GetObjectByTag("door_lis_ddcr2e2")));
    DelayCommand(601.0, SetLocked(GetObjectByTag("door_lis_ddcr2e2"), TRUE));

    //do visual effects
    oTarget=GetNearestObjectByTag("wp_lis_ddgrgreff");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), GetLocation(oTarget));
    DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWSTUN), GetLocation(oDoor)));
    DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWSTUN), GetLocation(GetObjectByTag("door_lis_ddcr2e1"))));
    DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWSTUN), GetLocation(GetObjectByTag("door_lis_ddcr2e2"))));

    //And destroy everything!
    oChest=GetObjectByTag("plc_lis_ddgrhnds");
    DestroyObject(GetItemPossessedBy(oChest, "lis_ddflwr"));

    oChest=GetObjectByTag("plc_lis_ddgreyer");
    object oItem = GetFirstItemInInventory(oChest);
    while (GetIsObjectValid(oItem))
    {DestroyObject(oItem);oItem = GetNextItemInInventory(oChest);}

    oChest=GetObjectByTag("plc_lis_ddgreyel");
    oItem = GetFirstItemInInventory(oChest);
    while (GetIsObjectValid(oItem))
    {DestroyObject(oItem);oItem = GetNextItemInInventory(oChest);}

}
