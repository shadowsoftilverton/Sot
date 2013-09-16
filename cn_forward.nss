int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetLocalInt(OBJECT_SELF, "moveforward") > 0 || GetLocalInt(OBJECT_SELF, "takeforward") > 0);
  return l_iResult;
}
