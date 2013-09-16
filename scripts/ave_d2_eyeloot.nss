void main()
{
    object oChest=OBJECT_SELF;
    if(GetLocalInt(oChest,"ave_d2_chestcool")==0)
    {
        object oClear=GetFirstItemInInventory(oChest);
        while(GetIsObjectValid(oClear))
        {
            DestroyObject(oClear);
            oClear=GetNextItemInInventory(oChest);
        }
        CreateItemOnObject("ave_d2_eyegem");
        CreateItemOnObject("ave_d2_eyegem");
        SetLocalInt(oChest,"ave_d2_chestcool",1);
        DelayCommand(1800.0,SetLocalInt(oChest,"ave_d2_chestcool",0));
    }
}
