int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetLocalInt(OBJECT_SELF, "movebackward") > 0 || GetLocalInt(OBJECT_SELF, "takebackward") > 0);
  return l_iResult;
}
