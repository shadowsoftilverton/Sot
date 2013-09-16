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
    if ( GetHasSkill(38, oPC)  &&  GetIsSkillSuccessful(oPC, 38, 20) )
    {
        // Have text appear over the PC's head.
        FloatingTextStringOnCreature("You gaze down to what appears to be the underdark. Vile abominations sometimes emerge from the darkness below", oPC, FALSE);
                GiveXPToCreature(oPC, 50);
    }
    else
    {
        // Have text appear over the PC's head.
        FloatingTextStringOnCreature("You see a dark pit", oPC, FALSE);
    }
}
