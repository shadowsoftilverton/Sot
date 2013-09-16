void main()
{
if (GetGold(GetPCSpeaker()) >= 1000)
    {
SetLocalInt(OBJECT_SELF,"iBet",1000);
TakeGoldFromCreature(1000, GetPCSpeaker(), TRUE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"iBet",0);
    }

}
