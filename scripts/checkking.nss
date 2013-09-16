#include "chessinc"

void main()
{
    int nNewPosition, nPosition, nPiece, nSide;
    object oGM = GetNearestObjectByTag("gamemaster");
    object oRook;

    CheckBishop();
    CheckRook();

    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    nPiece = GetLocalInt(OBJECT_SELF, "nPiece");
    nSide = GetLocalInt(oGM, "Turn");

    //check forward-left
    if (GetLocalInt(OBJECT_SELF, "move_fl") > 0 || GetLocalInt(OBJECT_SELF, "take_fl") == 1)
    {
        nNewPosition = nPosition + 7*nSide;
        if(KingInCheckAfterMove(nPosition, nNewPosition, nPiece, nSide))
        {
            SetLocalInt(OBJECT_SELF, "move_fl", 0);
            SetLocalInt(OBJECT_SELF, "take_fl", 0);
        }
    }

    //check forward
    if (GetLocalInt(OBJECT_SELF, "moveforward") > 0 || GetLocalInt(OBJECT_SELF, "takeforward") == 1)
    {
        nNewPosition = nPosition + 8*nSide;
        if(KingInCheckAfterMove(nPosition, nNewPosition, nPiece, nSide))
        {
            SetLocalInt(OBJECT_SELF, "moveforward", 0);
            SetLocalInt(OBJECT_SELF, "takeforward", 0);
        }
    }

    //check forward-right
    if (GetLocalInt(OBJECT_SELF, "move_fr") > 0 || GetLocalInt(OBJECT_SELF, "take_fr") == 1)
    {
        nNewPosition = nPosition + 9*nSide;
        if(KingInCheckAfterMove(nPosition, nNewPosition, nPiece, nSide))
        {
            SetLocalInt(OBJECT_SELF, "move_fr", 0);
            SetLocalInt(OBJECT_SELF, "take_fr", 0);
        }
    }

    //check left
    if (GetLocalInt(OBJECT_SELF, "moveleft") > 0 || GetLocalInt(OBJECT_SELF, "takeleft") == 1)
    {
        nNewPosition = nPosition - nSide;
        if(KingInCheckAfterMove(nPosition, nNewPosition, nPiece, nSide))
        {
            SetLocalInt(OBJECT_SELF, "moveleft", 0);
            SetLocalInt(OBJECT_SELF, "takeleft", 0);
        }
    }

    //check right
    if (GetLocalInt(OBJECT_SELF, "moveright") > 0 || GetLocalInt(OBJECT_SELF, "takeright") == 1)
    {
        nNewPosition = nPosition + nSide;
        if(KingInCheckAfterMove(nPosition, nNewPosition, nPiece, nSide))
        {
            SetLocalInt(OBJECT_SELF, "moveright", 0);
            SetLocalInt(OBJECT_SELF, "takeright", 0);
        }
    }

    //check backward-left
    if (GetLocalInt(OBJECT_SELF, "move_bl") > 0 || GetLocalInt(OBJECT_SELF, "take_bl") == 1)
    {
        nNewPosition = nPosition - 9*nSide;
        if(KingInCheckAfterMove(nPosition, nNewPosition, nPiece, nSide))
        {
            SetLocalInt(OBJECT_SELF, "move_bl", 0);
            SetLocalInt(OBJECT_SELF, "take_bl", 0);
        }
    }

    //check backward
    if (GetLocalInt(OBJECT_SELF, "movebackward") > 0 || GetLocalInt(OBJECT_SELF, "takebackward") == 1)
    {
        nNewPosition = nPosition - 8*nSide;
        if(KingInCheckAfterMove(nPosition, nNewPosition, nPiece, nSide))
        {
            SetLocalInt(OBJECT_SELF, "movebackward", 0);
            SetLocalInt(OBJECT_SELF, "takebackward", 0);
        }
    }

    //check backward-right
    if (GetLocalInt(OBJECT_SELF, "move_br") > 0 || GetLocalInt(OBJECT_SELF, "take_br") == 1)
    {
        nNewPosition = nPosition - 7*nSide;
        if(KingInCheckAfterMove(nPosition, nNewPosition, nPiece, nSide))
        {
            SetLocalInt(OBJECT_SELF, "move_br", 0);
            SetLocalInt(OBJECT_SELF, "take_br", 0);
        }
    }

    if (GetLocalInt(OBJECT_SELF, "bOriginalPos") == 1)
    {
        //check castling queen-side
        SetLocalInt(OBJECT_SELF, "castlequeenside", 1);
        oRook = GetObjectArray(oGM, "oSquare", nPosition-4);
        if (GetIntArray(oGM, "nSquare", nPosition-1) != 0)
        {   SetLocalInt(OBJECT_SELF, "castlequeenside", 0);  }
        else if (GetIntArray(oGM, "nSquare", nPosition-2) != 0)
        {   SetLocalInt(OBJECT_SELF, "castlequeenside", 0);  }
        else if (GetIntArray(oGM, "nSquare", nPosition-3) != 0)
        {   SetLocalInt(OBJECT_SELF, "castlequeenside", 0);  }
        else if (GetLocalInt(oRook, "nPiece") != 2*nSide)
        {   SetLocalInt(OBJECT_SELF, "castlequeenside", 0);  }
        else if (GetLocalInt(oRook, "bOriginalPos") == 0)
        {   SetLocalInt(OBJECT_SELF, "castlequeenside", 0);  }

        //check castling king-side
        SetLocalInt(OBJECT_SELF, "castlekingside", 1);
        oRook = GetObjectArray(oGM, "oSquare", nPosition+3);
        if (GetIntArray(oGM, "nSquare", nPosition+1) != 0)
        {   SetLocalInt(OBJECT_SELF, "castlekingside", 0);  }
        else if (GetIntArray(oGM, "nSquare", nPosition+2) != 0)
        {   SetLocalInt(OBJECT_SELF, "castlekingside", 0);  }
        else if (GetLocalInt(oRook, "nPiece") != 2*nSide)
        {   SetLocalInt(OBJECT_SELF, "castlekingside", 0);  }
        else if (GetLocalInt(oRook, "bOriginalPos") == 0)
        {   SetLocalInt(OBJECT_SELF, "castlekingside", 0);  }
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "castlequeenside", 0);
        SetLocalInt(OBJECT_SELF, "castlekingside", 0);
    }
}
