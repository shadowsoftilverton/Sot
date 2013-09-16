void main()
{
if (GetGold(GetPCSpeaker()) >= 5)
    {
SetLocalInt(OBJECT_SELF,"iBet",5);
TakeGoldFromCreature(5, GetPCSpeaker(), TRUE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"iBet",0);
    }

}
