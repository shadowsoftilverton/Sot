void main()
{
    object oDoor = GetObjectByTag("Moira_door_up");
    if (GetLocked(oDoor))
    {
        SetLocked(oDoor, 0);
    }
}
