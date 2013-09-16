/*
Monster Slots
by Ray Miller
kaynekayne@bigfoot.com
*/
int StartingConditional()
{
if(!GetLocalInt(GetPCSpeaker(), "smach_iCurrentBet")) SetLocalInt(GetPCSpeaker(), "smach_iCurrentBet", 1);
SetCustomToken(100, IntToString(GetLocalInt(OBJECT_SELF, "bet" + IntToString(GetLocalInt(GetPCSpeaker(), "smach_iCurrentBet")))));
return TRUE;
}
