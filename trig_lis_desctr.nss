//###########################
//## The coolest flavor text script in existence ##
//###########################

void main()
{
object oPC = GetEnteringObject();

if(GetIsPC(oPC) == TRUE)
    {
    string sString = GetName(OBJECT_SELF);
    string sVal = GetStringLeft(sString, 6);
    string sVar = GetStringRight(sString, 6);
    string sTest = GetLocalString(oPC, sVar);

    if(sTest != sVal)
        {
        //do once
        SetLocalString(oPC, sVar, sVal);
        //flavor text
        FloatingTextStringOnCreature("[" + sString +"]", oPC, TRUE);
//        SendMessageToPC(oPC, sString);
        }
    }
}
