void main()
{
    //Define Variables
    object oObject=OBJECT_SELF;
    object oPC=GetLastUsedBy();
    float fDirection=GetFacing(oObject);
    int iTurn=GetLocalInt(OBJECT_SELF, "current");
    string sString;
    int iSolved;
    //turn the statue!
    fDirection=(fDirection+90.0);
    SetFacing(fDirection);
    iTurn=iTurn+1;
    if (iTurn==5){iTurn=1;}
    SetLocalInt(OBJECT_SELF, "current", iTurn);
    if (iTurn==1){sString=GetLocalString(OBJECT_SELF, "symbol1");}
    if (iTurn==2){sString=GetLocalString(OBJECT_SELF, "symbol2");}
    if (iTurn==3){sString=GetLocalString(OBJECT_SELF, "symbol3");}
    if (iTurn==4){sString=GetLocalString(OBJECT_SELF, "symbol4");}

    PlaySound("as_sw_stoneop1");
    FloatingTextStringOnCreature("[You turn the prism some, changing its facing. It now shows " + sString +".]", oPC);
    SetDescription(OBJECT_SELF, "This stone prism seems to be possible to turn, and on it symbols have been carved. The sides show " + GetLocalString(OBJECT_SELF, "symbol1") + ", " + GetLocalString(OBJECT_SELF, "symbol2") + ", " + GetLocalString(OBJECT_SELF, "symbol3") + ", and " + GetLocalString(OBJECT_SELF, "symbol4") +". It currently shows " + sString +".");
    //Check the individual statue if it is solved
    SetLocalInt(OBJECT_SELF, "solved", 0);
    string sCorrect=GetLocalString(OBJECT_SELF, "correct");
    if (sString==sCorrect){SetLocalInt(OBJECT_SELF,"solved",1);}
}
