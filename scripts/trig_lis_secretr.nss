void main()
{

//Variables
    string sTarget=GetLocalString(OBJECT_SELF, "ToFind");
    object oTarget=GetNearestObjectByTag(sTarget);

//If already run and supposed to only run once - piss off
    if (GetLocalInt(OBJECT_SELF,"FireOnce")==1)
    {
        if (GetLocalInt(OBJECT_SELF,"FiredOnce")==1)
        {return;}
    }

    //Now make the target placeable not usable
    SetUseableFlag(oTarget, FALSE);
    SetLocalInt(OBJECT_SELF,"FiredOnce",1);
}
