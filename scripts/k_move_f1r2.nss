#include "chessinc"

void main()
{
    int nSide, nPosition, nNewPosition;

    nSide=GetLocalInt(GetNearestObjectByTag("gamemaster"), "Turn");

    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    nNewPosition = nPosition + 10*nSide;
    MovePiece(nPosition, nNewPosition);
}
