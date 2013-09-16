//Reset all the statues in the demesne crypt, and mark self as used.
//define variables

void main()
{

    object oTarget;
    int iFacing;
    float fFacing;

    //if not needed, abort
    if (GetLocalInt(OBJECT_SELF, "randomized")==1)
    {return;}

    //Make the Book say NOTHING!
    SetDescription(GetNearestObjectByTag("plc_lis_ddcrqd2t"), "The huge statue is holding a huge book in its hands, as if prompting the text to be read. The pages are, however, completely empty.");

    //turn the statues and set their "solved" status to 0
    oTarget=GetObjectByTag("plac_lis_ddcrst1");
    iFacing=GetLocalInt(oTarget,"OFACING"+IntToString(d3()));
    fFacing=IntToFloat(iFacing);
    AssignCommand(oTarget, SetFacing(fFacing));
    SetLocalInt(oTarget, "CFACING", 0);
    SetUseableFlag(oTarget, TRUE);

    oTarget=GetObjectByTag("plac_lis_ddcrst2");
    iFacing=GetLocalInt(oTarget,"OFACING"+IntToString(d3()));
    fFacing=IntToFloat(iFacing);
    AssignCommand(oTarget, SetFacing(fFacing));
    SetLocalInt(oTarget, "CFACING", 0);
    SetUseableFlag(oTarget, TRUE);

    oTarget=GetObjectByTag("plac_lis_ddcrst3");
    iFacing=GetLocalInt(oTarget,"OFACING"+IntToString(d3()));
    fFacing=IntToFloat(iFacing);
    AssignCommand(oTarget, SetFacing(fFacing));
    SetLocalInt(oTarget, "CFACING", 0);
    SetUseableFlag(oTarget, TRUE);

    oTarget=GetObjectByTag("plac_lis_ddcrst4");
    iFacing=GetLocalInt(oTarget,"OFACING"+IntToString(d3()));
    fFacing=IntToFloat(iFacing);
    AssignCommand(oTarget, SetFacing(fFacing));
    SetLocalInt(oTarget, "CFACING", 0);
    SetUseableFlag(oTarget, TRUE);

    oTarget=GetObjectByTag("plac_lis_ddcrst5");
    iFacing=GetLocalInt(oTarget,"OFACING"+IntToString(d3()));
    fFacing=IntToFloat(iFacing);
    AssignCommand(oTarget, SetFacing(fFacing));
    SetLocalInt(oTarget, "CFACING", 0);
    SetUseableFlag(oTarget, TRUE);

    oTarget=GetObjectByTag("plac_lis_ddcrst6");
    iFacing=GetLocalInt(oTarget,"OFACING"+IntToString(d3()));
    fFacing=IntToFloat(iFacing);
    AssignCommand(oTarget, SetFacing(fFacing));
    SetLocalInt(oTarget, "CFACING", 0);
    SetUseableFlag(oTarget, TRUE);

    oTarget=GetObjectByTag("plac_lis_ddcrst7");
    iFacing=GetLocalInt(oTarget,"OFACING"+IntToString(d3()));
    fFacing=IntToFloat(iFacing);
    AssignCommand(oTarget, SetFacing(fFacing));
    SetLocalInt(oTarget, "CFACING", 0);
    SetUseableFlag(oTarget, TRUE);

    oTarget=GetObjectByTag("plc_lis_ddqd2ink");
    SetLocalInt(oTarget,"attempts",0);

    SetLocalInt(OBJECT_SELF,"randomized",1);
}
