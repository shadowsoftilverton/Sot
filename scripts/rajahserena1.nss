//::///////////////////////////////////////////////
//:: FileName rajahserena1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/30/2012 3:25:50 PM
//:://////////////////////////////////////////////


int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    string name = "Serena" ;
    string name2= GetName(GetPCSpeaker(),TRUE);

    if(name2== name)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
