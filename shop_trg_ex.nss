void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        DeleteLocalInt(oPC, "ShopAllowedArea");
    }
}
