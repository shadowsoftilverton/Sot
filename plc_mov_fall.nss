void main()
{
    object oUser = GetLastUsedBy();
    vector vUser = GetPosition(oUser);
    string sDestination = GetLocalString(OBJECT_SELF, "transition_tag");
    object oDestination = GetWaypointByTag(sDestination);
    vector vDestination = GetPosition(oDestination);
    float fUser = vUser.z;
    float fDestination = vDestination.z;
    int nDice = FloatToInt(fUser - fDestination);
    int nDamage = d2(nDice);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oUser);
    AssignCommand(oUser, ActionJumpToLocation(GetLocation(oDestination)));
}
