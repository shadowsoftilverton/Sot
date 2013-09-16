int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetLocalInt(OBJECT_SELF, "GameState") == 1);
  return l_iResult;
}
