void main()
{
if (GetGold(GetPCSpeaker()) >= 5000)
    {
SetLocalInt(OBJECT_SELF,"iBet",5000);
TakeGoldFromCreature(5000, GetPCSpeaker(), TRUE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"iBet",0);
    }

}
