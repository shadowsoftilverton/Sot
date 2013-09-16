void main()
{
object oDoor = GetObjectByTag("ara_e_cathedral_exit");
if (GetLocked(oDoor))
{
SetLocked(oDoor, 0);
}
}
