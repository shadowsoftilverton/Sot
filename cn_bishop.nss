int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetTag(OBJECT_SELF) == "bishop_w" || GetTag(OBJECT_SELF) == "bishop_b");
  return l_iResult;
}
