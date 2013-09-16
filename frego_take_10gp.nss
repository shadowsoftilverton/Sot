void main()
{
if (GetGold(GetPCSpeaker()) >= 10)
    {
SetLocalInt(OBJECT_SELF,"iBet",10);
TakeGoldFromCreature(10, GetPCSpeaker(), TRUE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"iBet",0);
    }

}
