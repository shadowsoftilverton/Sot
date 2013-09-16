void main()
{

int iBet = GetLocalInt(OBJECT_SELF,"iBet");
TakeGoldFromCreature(iBet, GetPCSpeaker(), TRUE);
}
