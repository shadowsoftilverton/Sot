#include "engine"

void main()
{
    // Get the creature who triggered this event.
    object oPC = GetLastUsedBy();

    // Only fire once per PC.
    if ( GetLocalInt(oPC, "DO_ONCE__" + GetTag(OBJECT_SELF)) )
        return;
    SetLocalInt(oPC, "DO_ONCE__" + GetTag(OBJECT_SELF), TRUE);

    // If a skill check (perform) is successful.
    if ( GetHasSkill(40, oPC)  &&  GetIsSkillSuccessful(oPC, 40, 25) )
    {
        // Have text appear over the PC's head.
        FloatingTextStringOnCreature("The old shield is decorated with a hunting horn and a six pointed star, you identify this as the sign of Oghrann, an old dwarven realm.", oPC, FALSE);
                GiveXPToCreature(oPC, 50);
    }
    else
    {
        // Have text appear over the PC's head.
        FloatingTextStringOnCreature("The old shield is decorated with a hunting horn and a six pointed star.", oPC, FALSE);
    }
}
