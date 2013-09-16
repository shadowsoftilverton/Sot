int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetLocalInt(OBJECT_SELF, "move_br") > 0 || GetLocalInt(OBJECT_SELF, "take_br") > 0);
  return l_iResult;
}
