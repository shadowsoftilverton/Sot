#include "chessinc"

int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetLocalInt(OBJECT_SELF, "move_fl") > 0);
  if(l_iResult)
  {
    object oGM = GetNearestObjectByTag("gamemaster");
    int nPos = GetLocalInt(OBJECT_SELF, "nPosition");
    int nTurn = GetLocalInt(oGM, "Turn");
    SetCustomToken(100, MovePositions(nPos,nPos+(7*nTurn)));
  }
  return l_iResult;
}
