void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        SetLocalInt(oPC, "ShopAllowedArea", 1);
    }
}
