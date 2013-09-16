/*
Monster Slots
By Ray Miller
kaynekayne@bigfoot.com
*/
void main()
{
if(GetLocalInt(GetPCSpeaker(), "smach_iCurrentBet") > 1)
SetLocalInt(GetPCSpeaker(), "smach_iCurrentBet", GetLocalInt(GetPCSpeaker(), "smach_iCurrentBet") - 1);
}
