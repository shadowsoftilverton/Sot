void main()
{
    object oNPC = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int nGold = GetGold(oPC);
    int nDole = d4(2);

    if(nGold >= 9)
    {
        TakeGoldFromCreature(nDole, oPC, TRUE);
    }

    else
    {
        string sPC = "I'm low on funds myself.";
        string sNPC = "Bah, cheapskate...";

        AssignCommand(oPC, SpeakString(sPC, TALKVOLUME_TALK));
        DelayCommand(2.0f, SpeakString(sNPC, TALKVOLUME_TALK));
    }
}
