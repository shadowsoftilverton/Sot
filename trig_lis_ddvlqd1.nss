void main()
{
    //Define Variables
    object oPC=GetLastUsedBy();
    object oTarget;
    int iChance;
    string sString;

    //Fix the "solved" status of all statues and randomize the puzzle
    //But first, make sure it happens only once!
    if (GetLocalInt(OBJECT_SELF, "randomized")==1)
    {return;}

    oTarget=GetObjectByTag("plc_lis_ddcrfqd1");
    iChance=d4(1);
    if (iChance==1){sString=GetLocalString(oTarget, "symbol1");}
    if (iChance==2){sString=GetLocalString(oTarget, "symbol2");}
    if (iChance==3){sString=GetLocalString(oTarget, "symbol3");}
    if (iChance==4){sString=GetLocalString(oTarget, "symbol4");}
    SetDescription(oTarget, "This stone prism seems to be possible to turn, and on it symbols have been carved. The sides show " + GetLocalString(oTarget, "symbol1") + ", " + GetLocalString(oTarget, "symbol2") + ", " + GetLocalString(oTarget, "symbol3") + ", and " + GetLocalString(oTarget, "symbol4") +". It currently shows " + sString +".");
    SetLocalInt(oTarget,"current",iChance);
    SetLocalInt(oTarget,"solved",0);
    if (sString==GetLocalString(oTarget,"correct"))
    {SetLocalInt(oTarget,"solved",1);}

    oTarget=GetObjectByTag("plc_lis_ddcrfqd2");
    iChance=d4(1);
    if (iChance==1){sString=GetLocalString(oTarget, "symbol1");}
    if (iChance==2){sString=GetLocalString(oTarget, "symbol2");}
    if (iChance==3){sString=GetLocalString(oTarget, "symbol3");}
    if (iChance==4){sString=GetLocalString(oTarget, "symbol4");}
    SetDescription(oTarget, "This stone prism seems to be possible to turn, and on it symbols have been carved. The sides show " + GetLocalString(oTarget, "symbol1") + ", " + GetLocalString(oTarget, "symbol2") + ", " + GetLocalString(oTarget, "symbol3") + ", and " + GetLocalString(oTarget, "symbol4") +". It currently shows " + sString +".");
    SetLocalInt(oTarget,"current",iChance);
    SetLocalInt(oTarget,"solved",0);
    if (sString==GetLocalString(oTarget,"correct"))
    {SetLocalInt(oTarget,"solved",1);}

    oTarget=GetObjectByTag("plc_lis_ddcrfqd3");
    iChance=d4(1);
    if (iChance==1){sString=GetLocalString(oTarget, "symbol1");}
    if (iChance==2){sString=GetLocalString(oTarget, "symbol2");}
    if (iChance==3){sString=GetLocalString(oTarget, "symbol3");}
    if (iChance==4){sString=GetLocalString(oTarget, "symbol4");}
    SetDescription(oTarget, "This stone prism seems to be possible to turn, and on it symbols have been carved. The sides show " + GetLocalString(oTarget, "symbol1") + ", " + GetLocalString(oTarget, "symbol2") + ", " + GetLocalString(oTarget, "symbol3") + ", and " + GetLocalString(oTarget, "symbol4") +". It currently shows " + sString +".");
    SetLocalInt(oTarget,"current",iChance);
    SetLocalInt(oTarget,"solved",0);
    if (sString==GetLocalString(oTarget,"correct"))
    {SetLocalInt(oTarget,"solved",1);}

    oTarget=GetObjectByTag("plc_lis_ddcrfqd4");
    iChance=d4(1);
    if (iChance==1){sString=GetLocalString(oTarget, "symbol1");}
    if (iChance==2){sString=GetLocalString(oTarget, "symbol2");}
    if (iChance==3){sString=GetLocalString(oTarget, "symbol3");}
    if (iChance==4){sString=GetLocalString(oTarget, "symbol4");}
    SetDescription(oTarget, "This stone prism seems to be possible to turn, and on it symbols have been carved. The sides show " + GetLocalString(oTarget, "symbol1") + ", " + GetLocalString(oTarget, "symbol2") + ", " + GetLocalString(oTarget, "symbol3") + ", and " + GetLocalString(oTarget, "symbol4") +". It currently shows " + sString +".");
    SetLocalInt(oTarget,"current",iChance);
    SetLocalInt(oTarget,"solved",0);
    if (sString==GetLocalString(oTarget,"correct"))
    {SetLocalInt(oTarget,"solved",1);}

    SetLocalInt(OBJECT_SELF, "randomized",1);
    DelayCommand(25.0, SetLocalInt(OBJECT_SELF, "randomized", 0));


}
