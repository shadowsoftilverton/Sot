void main()
{
    object oTarget;

    if (GetLocalInt (OBJECT_SELF,"activate") == 0)
    {

        oTarget = GetObjectByTag("tt_gate");
        SetLocalInt(oTarget, "activate", 1);
        ActionPlayAnimation (ANIMATION_PLACEABLE_OPEN);
    }
    else
    {

        oTarget = GetObjectByTag("tt_gate");
        SetLocalInt(oTarget, "activate", 0);
        ActionPlayAnimation (ANIMATION_PLACEABLE_CLOSE);
    }
}






/*

void main()
{
    if (GetLocalInt (OBJECT_SELF,"activate") == 0)
    {
        SetLocalInt (OBJECT_SELF,"activate",1);
        ActionPlayAnimation (ANIMATION_PLACEABLE_OPEN);
    }
    else
    {
        SetLocalInt (OBJECT_SELF,"activate",0);
        ActionPlayAnimation (ANIMATION_PLACEABLE_CLOSE);
    }
}







