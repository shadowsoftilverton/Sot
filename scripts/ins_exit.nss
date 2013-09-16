void main()
{
    object oArea = OBJECT_SELF;
    object oCreature = GetExitingObject();

    // Need to check if we have to collapse the instance...
    //
    // This means I need to check if there's a PC going between transitions.
    // Actually, maybe I can tag the EXIT transitions that I have to set via
    // programming to force the instance to check itself. That works, actually!

}
