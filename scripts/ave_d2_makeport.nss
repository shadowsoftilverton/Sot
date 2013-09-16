void main()
{
    location lLoc=GetLocation(GetObjectByTag("ave_d2_guardportmain"));
    object oPort=CreateObject(OBJECT_TYPE_PLACEABLE,"ave_d2_port02",lLoc,TRUE);
    DelayCommand(1800.0,DestroyObject(oPort));
}
