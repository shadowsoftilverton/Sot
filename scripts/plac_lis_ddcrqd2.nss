void main()
{
    //Define Variables
    object oObject=OBJECT_SELF;
    object oPC=GetLastUsedBy();
    float fDirection;
    int iSolvedFacing=GetLocalInt(OBJECT_SELF,"SFACING");

    //turn the statue...
    fDirection=GetFacing(OBJECT_SELF);
    fDirection=(fDirection+45.0);
    if (fDirection==405.0){fDirection=45.0;}
    SetFacing(fDirection);
    PlaySound("as_dr_stonmedop1");

    //Check the individual statue if it is solved
    int iDirection=(FloatToInt(fDirection));
    //This line is a debug line to show facing numbers
    //SpeakString (IntToString(iDirection));
    SetLocalInt(OBJECT_SELF, "CFACING",0);
    if(iDirection==iSolvedFacing)
    {
        SetLocalInt(OBJECT_SELF, "CFACING",1);
    }
}
