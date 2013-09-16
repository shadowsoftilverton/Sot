int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetTag(OBJECT_SELF) == "knight_w" || GetTag(OBJECT_SELF) == "knight_b");
  return l_iResult;
}
