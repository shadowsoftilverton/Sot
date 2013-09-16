void main()
{
    object oGM = GetObjectByTag("gamemaster");

    // Hold turn changing
    SetLocalInt(oGM, "Promote_Turn_Hold", TRUE);
}
