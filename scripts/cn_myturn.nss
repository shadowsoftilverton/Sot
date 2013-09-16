int StartingConditional()
{
  int l_iResult;

  l_iResult = ((GetLocalInt(OBJECT_SELF, "nPiece") > 0 && GetLocalInt(GetNearestObjectByTag("gamemaster"), "Turn") == (-1)) || (GetLocalInt(OBJECT_SELF, "nPiece") < 0 && GetLocalInt(GetNearestObjectByTag("gamemaster"), "Turn") == 1));
  return l_iResult;
}
