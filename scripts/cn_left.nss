int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetLocalInt(OBJECT_SELF, "moveleft") > 0 || GetLocalInt(OBJECT_SELF, "takeleft") > 0);
  return l_iResult;
}
