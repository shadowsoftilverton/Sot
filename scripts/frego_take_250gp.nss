void main()
{
if (GetGold(GetPCSpeaker()) >= 250)
    {
SetLocalInt(OBJECT_SELF,"iBet",250);
TakeGoldFromCreature(250, GetPCSpeaker(), TRUE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"iBet",0);
    }

}
