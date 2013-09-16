int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetLocalInt(OBJECT_SELF, "moveright") > 0 || GetLocalInt(OBJECT_SELF, "takeright") > 0);
  return l_iResult;
}
