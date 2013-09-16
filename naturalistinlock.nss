void main()
{
object oDoor = GetObjectByTag("naturalistguild_out");
if (!GetLocked(oDoor))
{
SetLocked(oDoor, 1);
}
}
