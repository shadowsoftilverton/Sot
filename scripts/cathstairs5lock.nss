void main()
{
object oDoor = GetObjectByTag("cathedraldungeon");
if (!GetLocked(oDoor))
{
SetLocked(oDoor, 1);
}
}
