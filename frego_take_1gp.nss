void main()
{
if (GetGold(GetPCSpeaker()) >= 1)
    {
SetLocalInt(OBJECT_SELF,"iBet",1);
TakeGoldFromCreature(1, GetPCSpeaker(), TRUE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"iBet",0);
    }

}
