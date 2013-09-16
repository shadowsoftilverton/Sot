void main()
{
object oDoor = GetObjectByTag("cathedralstairs5");
if (!GetLocked(oDoor))
{
SetLocked(oDoor, 1);
}
}
