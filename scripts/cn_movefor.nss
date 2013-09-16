#include "chessinc"

int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetLocalInt(OBJECT_SELF, "moveforward") > 0);
  if(l_iResult)
  {
    object oGM = GetNearestObjectByTag("gamemaster");
    int nPos = GetLocalInt(OBJECT_SELF, "nPosition");
    int nTurn = GetLocalInt(oGM, "Turn");
    SetCustomToken(101, MovePositions(nPos,nPos+(8*nTurn)));
  }
  return l_iResult;
}
