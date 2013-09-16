void main()
{
    object oPC = GetLastUsedBy();
    object oSelf = OBJECT_SELF;

    string sTag = GetLocalString(oSelf, "conversation_tag");

    BeginConversation(sTag, oPC);
}
