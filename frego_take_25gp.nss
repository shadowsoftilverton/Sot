void main()
{
if (GetGold(GetPCSpeaker()) >= 25)
    {
SetLocalInt(OBJECT_SELF,"iBet",25);
TakeGoldFromCreature(25, GetPCSpeaker(), TRUE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"iBet",0);
    }

}
