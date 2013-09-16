void main()
{
    object oDoor = GetObjectByTag("Moira_door_down");
    if (GetLocked(oDoor))
    {
        SetLocked(oDoor, 0);
    }
}
