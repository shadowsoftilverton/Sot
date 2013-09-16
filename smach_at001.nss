/*
Monster Slots
by Ray Miller
kaynekayne@bigfoot.com
*/
void main()
{
if(GetLocalInt(GetPCSpeaker(), "smach_iCurrentBet") < GetLocalInt(OBJECT_SELF, "NumberOfBets"))
SetLocalInt(GetPCSpeaker(), "smach_iCurrentBet", GetLocalInt(GetPCSpeaker(), "smach_iCurrentBet") + 1);
}
