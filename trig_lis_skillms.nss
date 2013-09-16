void main()
{
    object oPC=GetEnteringObject();
    int iDC=GetLocalInt(OBJECT_SELF,"SkillDC");
    int iSkill=GetLocalInt(OBJECT_SELF, "SkillType");
    int iRoll;
    string sSuccess;
    sSuccess=GetLocalString(OBJECT_SELF,"RollSuccess");

    //do not repeat if already successful
    string sVal = GetStringLeft(sSuccess, 6);
    string sVar = GetStringRight(sSuccess, 6);
    string sTest = GetLocalString(oPC, sVar);
    if(sTest == sVal) return;

    //abort if skill fails
    iRoll=d20(1)+Std_GetSkillRank(iSkill, oPC, FALSE);
    if (iRoll<iDC) return;

    //if a K: skill, and no ranks invested, abort
    if (iSkill==7)
        if(!GetHasSkill(7, oPC)) return;

    if ((iSkill>28) && (iSkill<=44))
        if (!GetHasSkill(iSkill, oPC)) return;

    //assign skill to message, and, for K: skills, abort if no ranks are invested
    if (iSkill==6) sSuccess="[Listen: " + sSuccess +"]";
    if (iSkill==7) sSuccess="[Knowledge Arcana: ]" + sSuccess +"]";
    if (iSkill==14) sSuccess="[Search: " + sSuccess +"]";
    if (iSkill==16) sSuccess="[Spellcraft: "+ sSuccess +"]";
    if (iSkill==17) sSuccess="[Spot: " + sSuccess +"]";
    if (iSkill==19) sSuccess="[Use Magic Device: " + sSuccess +"]";
    if (iSkill==29) sSuccess="[Knowledge Nobility: " + sSuccess +"]";
    if (iSkill==30) sSuccess="[Knowledge Local: " + sSuccess +"]";
    if (iSkill==37) sSuccess="[Knowledge Engineering: " + sSuccess +"]";
    if (iSkill==38) sSuccess="[Knowledge Dungeoneering: " + sSuccess +"]";
    if (iSkill==39) sSuccess="[Knowledge Geography: " + sSuccess +"]";
    if (iSkill==40) sSuccess="[Knowledge History: " + sSuccess +"]";
    if (iSkill==41) sSuccess="[Knowledge Nature: " + sSuccess +"]";
    if (iSkill==42) sSuccess="[Knowledge Religion: " + sSuccess +"]";
    if (iSkill==43) sSuccess="[Knowledge Planes: " + sSuccess +"]";
    if (iSkill==44) sSuccess="[Survival: " + sSuccess +"]";
    SendMessageToPC(oPC, sSuccess);
    SetLocalString(oPC,sVar,sVal);
}
