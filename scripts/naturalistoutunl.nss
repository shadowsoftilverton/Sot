void main()
{
object oDoor = GetObjectByTag("naturalistguild_in");
if (GetLocked(oDoor))
{
SetLocked(oDoor, 0);
}
}
