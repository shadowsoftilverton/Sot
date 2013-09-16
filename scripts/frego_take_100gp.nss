void main()
{
if (GetGold(GetPCSpeaker()) >= 100)
    {
SetLocalInt(OBJECT_SELF,"iBet",100);
TakeGoldFromCreature(100, GetPCSpeaker(), TRUE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"iBet",0);
    }

}
