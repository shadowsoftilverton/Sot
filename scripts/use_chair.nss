void main()
{
    object chair = OBJECT_SELF;
    if (GetIsObjectValid(GetSittingCreature(chair))) return;

    AssignCommand(GetLastUsedBy(), ActionSit(chair));
}
