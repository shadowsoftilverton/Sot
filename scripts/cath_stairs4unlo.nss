void main()
{
object oDoor = GetObjectByTag("cathedralstairs3");
if (GetLocked(oDoor))
{
SetLocked(oDoor, 0);
}
}
