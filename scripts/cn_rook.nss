int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetTag(OBJECT_SELF) == "rook_w" || GetTag(OBJECT_SELF) == "rook_b");
  return l_iResult;
}
