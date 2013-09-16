#include "chessinc"

int StartingConditional()
{
  int l_iResult;

  l_iResult = (GetLocalInt(OBJECT_SELF, "takespaces") == 4);
  if(l_iResult)
  {
    object oGM = GetNearestObjectByTag("gamemaster");
    int nPos = GetLocalInt(OBJECT_SELF, "nPosition");
    int nTurn = GetLocalInt(oGM, "Turn");
    int nMovingDir = GetLocalInt(OBJECT_SELF, "movingdir");
    int x;
    switch(nMovingDir)
    {
      case 1: x=8; break;
      case 2: x=-8; break;
      case 3: x=-1; break;
      case 4: x=1; break;
      case 5: x=7; break;
      case 6: x=9; break;
      case 7: x=-9; break;
      case 8: x=-7; break;
    }
    SetCustomToken(110, MovePositions(nPos,nPos+x*4));
  }
  return l_iResult;
}
