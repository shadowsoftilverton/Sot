void main()
{

//Variables
    string sTarget=GetLocalString(OBJECT_SELF, "ToFind");
    string sMessage=GetLocalString(OBJECT_SELF, "Found");
    object oTarget=GetNearestObjectByTag(sTarget);
    object oPC=GetEnteringObject();
    int iDC;
    int iSkillSearch=Std_GetSkillRank(SKILL_SEARCH,oPC, FALSE);
    int iSkillSpot=Std_GetSkillRank(SKILL_SPOT,oPC, FALSE);
    int iSkillListen=Std_GetSkillRank(SKILL_LISTEN,oPC, FALSE);
    int iSkillRoll;
    int iSuccess;
    float fDelay;

//If already found - piss off
    if (GetLocalInt(OBJECT_SELF,"Found")==1)
    {return;}
//Also, there is no way spawned monsters should find this
    if (!GetIsPC(oPC))
    {return;}

//Skill Checks. Yes. Three Skills, but only if they have a DC!

    //Search check
    iDC=GetLocalInt(OBJECT_SELF,"Search");
    if (iDC>=1)
    {
        iSkillRoll=d20()+iSkillSearch;
        if (iSkillRoll>=iDC)
        {SetLocalInt(OBJECT_SELF,"Found",1);}
    }

    //Spot Check
    iDC=GetLocalInt(OBJECT_SELF,"Spot");
    if (iDC>=1)
    {
        iSkillRoll=d20()+iSkillSpot;
        if (iSkillRoll>=iDC)
        {SetLocalInt(OBJECT_SELF,"Found",1);}
    }

    //Listen Check
    iDC=GetLocalInt(OBJECT_SELF,"Listen");
    if (iDC>=1)
    {
        iSkillRoll=d20()+iSkillListen;
        if (iSkillRoll>=iDC)
        {SetLocalInt(OBJECT_SELF,"Found",1);}
    }

//If successful, spawn object oToSpawn at location of waypoint lTarget
//destroy the object after fDelay (Defaults to 20)

    if (GetLocalInt(OBJECT_SELF,"Found")==1)
    {
        //Step1: Alert PC
        //Have the entering object speak something (if a pc also send a message)
        AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_LOOKHERE, OBJECT_SELF));
        FloatingTextStringOnCreature(sMessage, oPC);

        //If a Henchman, Summon, or other minion finds it we still want to be notified...
        object oMaster = GetMaster(oPC);
        if (GetIsObjectValid(oMaster))
        {
            AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_SEARCH));
            AssignCommand(oPC, SpeakString(GetName(oPC) + " alerts you to something."));
        }

        //Now make the target placeable usable, and make it unusable after the
        //set delay (Default to 60 seconds if nothing else is given)
        DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_HIT_ELECTRICAL), GetLocation(oTarget)));
        SetUseableFlag(oTarget, TRUE);

        fDelay=GetLocalFloat(OBJECT_SELF,"Delay");
        if (fDelay==0.0)
            {fDelay=60.0;}
        DelayCommand(fDelay+1.0, SetLocalInt(OBJECT_SELF, "Found", 0));
        DelayCommand(fDelay, SetUseableFlag(oTarget, FALSE));


        //Make sure it doesn't switch this all the time, etc
        SetLocalInt(OBJECT_SELF, "Found", 1);                  //don't run twice
        iSuccess==0;                                           //global fix
    }
}
