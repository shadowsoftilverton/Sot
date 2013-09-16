void main()
{
if (GetGold(GetPCSpeaker()) >= 10000)
    {
SetLocalInt(OBJECT_SELF,"iBet",10000);
TakeGoldFromCreature(10000, GetPCSpeaker(), TRUE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"iBet",0);
    }

}
