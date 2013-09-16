#include "chessinc"

int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetLocalInt(OBJECT_SELF, "takef1r2") == 1);
  if(l_iResult)
  {
    object oGM = GetNearestObjectByTag("gamemaster");
    int nPos = GetLocalInt(OBJECT_SELF, "nPosition");
    int nTurn = GetLocalInt(oGM, "Turn");
    SetCustomToken(103, MovePositions(nPos,nPos+(10*nTurn)));
  }
  return l_iResult;
}
