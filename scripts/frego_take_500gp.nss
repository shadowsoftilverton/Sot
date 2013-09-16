void main()
{
if (GetGold(GetPCSpeaker()) >= 500)
    {
SetLocalInt(OBJECT_SELF,"iBet",500);
TakeGoldFromCreature(500, GetPCSpeaker(), TRUE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"iBet",0);
    }

}
