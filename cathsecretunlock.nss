void main()
{
object oDoor = GetObjectByTag("ara_e_cathedral_entrance");
if (GetLocked(oDoor))
{
SetLocked(oDoor, 0);
}
}
