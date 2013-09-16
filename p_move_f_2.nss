#include "chessinc"

void main()
{
    int nSide, nPosition, nNewPosition;
    object oGM = GetNearestObjectByTag("gamemaster");

    nSide=GetLocalInt(oGM, "Turn");

    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    nNewPosition = nPosition + 16*nSide;
    MovePiece(nPosition, nNewPosition);
    if (GetLocalInt(OBJECT_SELF, "nPosition") == nNewPosition)
    {
        if ((nNewPosition&7) != 0)
        {
            if (GetIntArray(oGM, "nSquare", nNewPosition-1)*nSide == -1)
            {
                SetLocalInt(oGM, "enpassant", 1);
                SetLocalInt(oGM, "enpassantpos", nNewPosition - 8*nSide);
            }
        }
        if ((nNewPosition&7) != 7)
        {
            if (GetIntArray(oGM, "nSquare", nNewPosition+1)*nSide == -1)
            {
                SetLocalInt(oGM, "enpassant", 1);
                SetLocalInt(oGM, "enpassantpos", nNewPosition - 8*nSide);
            }
        }
    }
}
