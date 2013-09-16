void main()
{
object oDoor = GetObjectByTag("cathedralstairs4");
if (GetLocked(oDoor))
{
SetLocked(oDoor, 0);
}
}
