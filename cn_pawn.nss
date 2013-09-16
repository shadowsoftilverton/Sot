int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetTag(OBJECT_SELF) == "pawn_w" || GetTag(OBJECT_SELF) == "pawn_b");
  return l_iResult;
}
