void main()
{
    /*
     * Full-Edge Area Transition
     * -------------------------
     * Based on The Mighty Teleport Script from Richard Conner
     * Jonathan Warrington
     *
     * Usage
     * -----
     * Setup a waypoint in each destination area ending in
     * "Marker", for example "MyAreaMarker".  You just need
     * one marker in the area, and it can be anywhere, it is
     * only used to identify that area as the destination area.
     * You then create a trigger of whatever kind (can be
     * generic or an area transition), and setup the onclick
     * and onenter events to point to this script.  Rename
     * the tag of the transition trigger to the name of the
     * destination without the "Marker".  So, for the example
     * above, you'd name it "MyArea".
     *
     * The trigger should be drawn such that it is within
     * 1/2 of the square size in the toolset, right
     * against the edge.  It uses the characters location
     * to determine on which edge of the destination area
     * it should appear.
     *
     * The only drawback to this is that it depends on the
     * size of the area, and the size has to be hardcoded
     * into this script.  I'd recommend saving it as eg.
     * transition_16x16.
     */
    // The area size.
    float xsize = 11.0;
    float ysize = 11.0;

    float border = 7.0;

    //Get the PC that just clicked on the transition
    object oClicker = GetEnteringObject();
    //Get the location of the PC
    location lLoc = GetLocation( oClicker );
    //Get the PC's postion
    vector vEnter = GetPositionFromLocation( lLoc );
    //The Trigger that's in the destination area
    //object oTrap = GetNearestTrapToObject (oClicker);
    //SendMessageToPC (oClicker, "trigger: " + GetTag (OBJECT_SELF));
    object oTran = GetObjectByTag( GetTag (OBJECT_SELF) + "Marker");

    if (!GetIsObjectValid (oTran))
    {
        SendMessageToPC (oClicker, "Unable to find destination tag for this transition - Please tell me (the admin) asap - thanks.");
    }
    //Get the destination area
    object oDestArea = GetArea( oTran );

    //SendMessageToPC (oClicker, "vector: " + FloatToString (vEnter.x) + ", " + FloatToString(vEnter.y));


    xsize *= 10.0;
    ysize *= 10.0;
    // Calculate the new position.. x stays the same
    // as this is a north-south transition, so we
    // just have to invert y.
    if (vEnter.y < border)
    {
        vEnter.y = ysize - border;
    } else if (vEnter.y > ysize - border)
    {
        vEnter.y = border;
    }

    if (vEnter.x < border)
    {
        vEnter.x = xsize - border;
    } else if (vEnter.x > xsize - border)
    {
        vEnter.x = border;
    }

    //Get the PC's facing
    float fFacing = GetFacingFromLocation( lLoc );
    //Create a new Location to place the PC in
    location locNew = Location( oDestArea, vEnter, fFacing );
    //Clear all PC actions, (Stop walking) and then jump
    //to the new location.
    AssignCommand( oClicker, ClearAllActions() );
    AssignCommand( oClicker, JumpToLocation( locNew ) );
}
