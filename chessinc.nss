//::///////////////////////////////////////////////
//:: Include file for chess.
//:: CHESSINC.NSS
//:://////////////////////////////////////////////
/*
    Most of the important functions for the
    chess module are contained in this script.

    Note to self - in the future, USE MORE COMMENTS! :)
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Last Modified: Aug 5, 2002
//:://////////////////////////////////////////////

#include "array4"

// constants
int BLACK = 0;
int WHITE = 1;

void Move(int nMoveSpaces);
void CheckBishop();
void MovePiece(int nOldPosition, int nNewPosition);
void TakePiece(int nOldPosition, int nNewPosition);
void CheckPawn();
void CheckRook();
void CheckKnight();
int CheckForCheck(int nPos, int nSide);
int CheckForCheckMate();
string MovePositions(int nStartPos, int nEndPos);
void StartFight(object oTarget);
void ContinueFight(object oTarget, int bAggressor);
int KingInCheckAfterMove(int nPosition, int nNewPosition, int nPiece, int nSide);
void PromotePawn(string sNewPiece, int nNewPiece);
// Cast a spell at oTarget.  Random based on color.
// - oTarget is the target to cast a spell at
// - nColor is the color of the piece that is casting the spell
void CastSpell(object oTarget, int nColor);

void CheckBishop()
{
    int nMoveUL, nMoveUR, nMoveDL, nMoveDR = 0;
    int nTakeUL, nTakeUR, nTakeDL, nTakeDR = 0;
    int x, y, xStart, yStart, nPosition, nPiece, nPieceCheck;
    object oGM;

    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    nPiece = GetLocalInt(OBJECT_SELF, "nPiece");

    oGM = GetNearestObjectByTag("gamemaster");

    xStart = nPosition&7;
    yStart = nPosition>>3;

    // check up-left
    y = 1;
    x = 1;
    while (TRUE)
    {
        if (yStart + y > 7) break;
        if (xStart - x < 0) break;
        nPieceCheck = (GetIntArray(oGM, "nSquare", (yStart+y)*8 + xStart - x));
        if (nPieceCheck * nPiece < 0)
        {
            nTakeUL = nMoveUL + 1;
            break;
        }
        if (nPieceCheck != 0) break;
        nMoveUL = y;
        y++;
        x++;
    }

    // check up-right
    y = 1;
    x = 1;
    while (TRUE)
    {
        if (yStart + y > 7) break;
        if (xStart + x > 7) break;
        nPieceCheck = (GetIntArray(oGM, "nSquare", (yStart+y)*8 + xStart + x));
        if (nPieceCheck * nPiece < 0)
        {
            nTakeUR = nMoveUR + 1;
            break;
        }
        if (nPieceCheck != 0) break;
        nMoveUR = y;
        y++;
        x++;
    }

    // check down-left
    y = 1;
    x = 1;
    while (TRUE)
    {
        if (yStart - y < 0) break;
        if (xStart - x < 0) break;
        nPieceCheck = (GetIntArray(oGM, "nSquare", (yStart-y)*8 + xStart - x));
        if (nPieceCheck * nPiece < 0)
        {
            nTakeDL = nMoveDL + 1;
            break;
        }
        if (nPieceCheck != 0) break;
        nMoveDL = y;
        y++;
        x++;
    }

    // check down-right
    y = 1;
    x = 1;
    while (TRUE)
    {
        if (yStart - y < 0) break;
        if (xStart + x > 7) break;
        nPieceCheck = (GetIntArray(oGM, "nSquare", (yStart-y)*8 + xStart + x));
        if (nPieceCheck * nPiece < 0)
        {
            nTakeDR = nMoveDR + 1;
            break;
        }
        if (nPieceCheck != 0) break;
        nMoveDR = y;
        y++;
        x++;
    }

    if (nPiece > 0)
    {
        SetLocalInt(OBJECT_SELF, "move_fl", nMoveUL);
        SetLocalInt(OBJECT_SELF, "move_fr", nMoveUR);
        SetLocalInt(OBJECT_SELF, "move_bl", nMoveDL);
        SetLocalInt(OBJECT_SELF, "move_br", nMoveDR);
        SetLocalInt(OBJECT_SELF, "take_fl", nTakeUL);
        SetLocalInt(OBJECT_SELF, "take_fr", nTakeUR);
        SetLocalInt(OBJECT_SELF, "take_bl", nTakeDL);
        SetLocalInt(OBJECT_SELF, "take_br", nTakeDR);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "move_fl", nMoveDR);
        SetLocalInt(OBJECT_SELF, "move_fr", nMoveDL);
        SetLocalInt(OBJECT_SELF, "move_bl", nMoveUR);
        SetLocalInt(OBJECT_SELF, "move_br", nMoveUL);
        SetLocalInt(OBJECT_SELF, "take_fl", nTakeDR);
        SetLocalInt(OBJECT_SELF, "take_fr", nTakeDL);
        SetLocalInt(OBJECT_SELF, "take_bl", nTakeUR);
        SetLocalInt(OBJECT_SELF, "take_br", nTakeUL);
    }
}

void MovePiece(int nOldPosition, int nNewPosition)
{
    object oGM, oKing;
    location lLoc;
    int nPiece, nTurn, nEnemyPiece, nKingPos, nTemp, nCheckMate;

    oGM = GetNearestObjectByTag("gamemaster");

    nPiece = GetLocalInt(OBJECT_SELF, "nPiece");
    nEnemyPiece = GetIntArray(oGM, "nSquare", nNewPosition);
    nTurn = GetLocalInt(oGM, "Turn");
    SetIntArray(oGM, "nSquare", nOldPosition, 0);
    SetIntArray(oGM, "nSquare", nNewPosition, nPiece);
    //find own king
    nKingPos = 0;
    while(TRUE)
    {
        nTemp = GetIntArray(oGM, "nSquare", nKingPos);
        if (nTemp == nTurn*6) break;
        nKingPos++;
    }
    if (CheckForCheck(nKingPos, nTurn))
    // if moving piece puts king in check, put stuff back
    {
        SetIntArray(oGM, "nSquare", nNewPosition, nEnemyPiece);
        SetIntArray(oGM, "nSquare", nOldPosition, nPiece);
        ActionSpeakString("Nope, the King will be in check if I move there!");
        return;
    }

    SetObjectArray(oGM, "oSquare", nOldPosition, oGM);
    SetObjectArray(oGM, "oSquare", nNewPosition, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "nPosition", nNewPosition);
    SetLocalInt(OBJECT_SELF, "bOriginalPos", 0);
    lLoc = GetLocationArray(oGM, "lSquare", nNewPosition);
    ActionForceMoveToLocation(lLoc, FALSE, 12.0);

    SetLocalInt(oGM, "enpassant", 0);
    nTurn = GetLocalInt(oGM, "Turn") * (-1);
    SetLocalInt(oGM, "Turn", nTurn);

    nCheckMate=CheckForCheckMate();
    if(nCheckMate==2)
    {
        AssignCommand(oGM,ActionSpeakString("Stalemate!", TALKVOLUME_SHOUT));
        SetLocalInt(oGM, "GameState", 3);
    }
    else if(nCheckMate==1)
    {
        AssignCommand(oGM,ActionSpeakString("Checkmate!", TALKVOLUME_SHOUT));
        SetLocalInt(oGM, "GameState", 3);

        // SPECIAL CHECKMATE SCRIPT
        //find opposing king
        object oCenter = GetObjectByTag("centerpoint");
        location lLoc = GetLocation(oCenter);

        nKingPos = 0;
        while(TRUE)
        {
            nTemp = GetIntArray(oGM, "nSquare", nKingPos);
            if (nTemp == nTurn*6) break;
            nKingPos++;
        }

        // Get the losing king object, what a dope.
        object oFailedKing = GetObjectArray(oGM, "oSquare", nKingPos);
        object oBlackKing = GetObjectByTag("king_b");
        // oWhiteKing is unnecessary
        // object oWhiteKing = GetObjectByTag("king_w");
        object oDragon;
        effect eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

        // Make the king killable
        SetPlotFlag(oFailedKing, FALSE);

        // May as well create some mayhem and let everyone get whacked
        int x;
        object oPiece,oTarget;
        for (x=0;x<64;x++)
        {
            oPiece = GetObjectArray(oGM, "oSquare", x);
            oTarget = GetLocalObject(oPiece, "target");
            if(GetIsObjectValid(oTarget)) SetPlotFlag(oTarget, FALSE);
            if(oPiece!=oGM && GetIsObjectValid(oPiece)) SetPlotFlag(oPiece, FALSE);
        }

        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eEffect, lLoc, 15.0);

        // Create a dragon of the winners color to kill their king.
        if (GetReputation(OBJECT_SELF, oBlackKing) == 0)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "whitedragon", lLoc);
            oDragon = GetObjectByTag("WhiteDragon");
        }
        else
        {
            CreateObject(OBJECT_TYPE_CREATURE, "blackdragon", lLoc);
            oDragon = GetObjectByTag("BlackDragon");
        }

        AssignCommand(oDragon, ActionSpeakString("Checkmate!", TALKVOLUME_SHOUT));
        DelayCommand(2.0, AssignCommand(oDragon,  ActionAttack(oFailedKing)));
        // END SPECIAL CHECKMATE SCRIPT
    }
    else
    {
        //find opposing king
        nKingPos = 0;
        while(TRUE)
        {
            nTemp = GetIntArray(oGM, "nSquare", nKingPos);
            if (nTemp == nTurn*6) break;
            nKingPos++;
        }
        if (CheckForCheck(nKingPos, nTurn)) SpeakString("Check!", TALKVOLUME_SHOUT);
    }
    return;
}

void TakePiece(int nOldPosition, int nNewPosition)
{
    object oGM, oTarget;
    location lLoc;
    int nPiece, nTurn, x;

    oGM = GetNearestObjectByTag("gamemaster");
    oTarget = GetObjectArray(oGM, "oSquare", nNewPosition);

    nTurn = GetLocalInt(oGM, "Turn");
    MovePiece(nOldPosition, nNewPosition);
    if (nTurn != GetLocalInt(oGM, "Turn")) StartFight(oTarget);
    return;
}

void CheckPawn()
{
    int nPosition, nSide, nPiece;
    object oGM;

    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    oGM = GetNearestObjectByTag("gamemaster");
    nPiece = GetIntArray(oGM, "nSquare", nPosition);

    nSide = GetLocalInt(oGM, "Turn");

    if (GetIntArray(oGM, "nSquare", nPosition + 8*nSide) == 0)
    {   SetLocalInt(OBJECT_SELF, "moveforwardone", 1);   }
    else
    {   SetLocalInt(OBJECT_SELF, "moveforwardone", 0);   }

    if (GetLocalInt(OBJECT_SELF, "bOriginalPos"))
    {
        if (GetIntArray(oGM, "nSquare", nPosition + 8*nSide) == 0
            && GetIntArray(oGM, "nSquare", nPosition + 16*nSide) == 0)
        {   SetLocalInt(OBJECT_SELF, "moveforwardtwo", 1);   }
        else
        {   SetLocalInt(OBJECT_SELF, "moveforwardtwo", 0);   }
    }
    else
    {   SetLocalInt(OBJECT_SELF, "moveforwardtwo", 0);   }

    SetLocalInt(OBJECT_SELF, "takeforwardleft", 0);
    if ( (nPiece == 1 && (nPosition&7) != 0) || (nPiece == (-1) && (nPosition&7) != 7) )
    {
        if (GetIntArray(oGM, "nSquare", nPosition + 7*nSide) * nPiece < 0)
        {   SetLocalInt(OBJECT_SELF, "takeforwardleft", 1); }
    }

    SetLocalInt(OBJECT_SELF, "takeforwardright", 0);
    if ( (nPiece == 1 && (nPosition&7) != 7) || (nPiece == (-1) && (nPosition&7) != 0) )
    {
        if (GetIntArray(oGM, "nSquare", nPosition + 9*nSide) * nPiece < 0)
        {   SetLocalInt(OBJECT_SELF, "takeforwardright", 1); }
    }

    SetLocalInt(OBJECT_SELF, "enpassantleft", 0);
    SetLocalInt(OBJECT_SELF, "enpassantright", 0);
    if (GetLocalInt(oGM, "enpassant") == 1)
    {
        if ( (nPiece == 1 && (nPosition&7) != 0) || (nPiece == -1 && (nPosition&7) != 7) )
        {
            if(GetLocalInt(oGM, "enpassantpos") == nPosition + 7*nSide)
                SetLocalInt(OBJECT_SELF, "enpassantleft", 1);
        }
        if ( (nPiece == 1 && (nPosition&7) != 7) || (nPiece == -1 && (nPosition&7) != 0) )
        {
            if(GetLocalInt(oGM, "enpassantpos") == nPosition + 9*nSide)
                SetLocalInt(OBJECT_SELF, "enpassantright", 1);
        }
    }
}

void CheckRook()
{
    int nMoveUp, nMoveDown, nMoveLeft, nMoveRight = 0;
    int nTakeUp, nTakeDown, nTakeLeft, nTakeRight = 0;
    int x, y, xStart, yStart, nPosition, nPiece, nPieceCheck, nTurn;
    object oGM, oKing;

    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    nPiece = GetLocalInt(OBJECT_SELF, "nPiece");

    oGM = GetNearestObjectByTag("gamemaster");
    xStart = nPosition&7;
    yStart = nPosition>>3;

    // check up
    y = 1;
    while (TRUE)
    {
        if (yStart + y > 7) break;
        nPieceCheck = (GetIntArray(oGM, "nSquare", (yStart+y)*8 + xStart));
        if (nPieceCheck * nPiece < 0)
        {
            nTakeUp = nMoveUp + 1;
            break;
        }
        if (nPieceCheck != 0) break;
        nMoveUp = y;
        y++;
    }

    // check down
    y = 1;
    while (TRUE)
    {
        if (yStart - y < 0) break;
        nPieceCheck = (GetIntArray(oGM, "nSquare", (yStart-y)*8 + xStart));
        if (nPieceCheck * nPiece < 0)
        {
            nTakeDown = nMoveDown + 1;
            break;
        }
        if (nPieceCheck != 0) break;
        nMoveDown = y;
        y++;
    }

    // check left
    x = 1;
    while (TRUE)
    {
        if (xStart - x < 0) break;
        nPieceCheck = (GetIntArray(oGM, "nSquare", yStart*8 + xStart-x));
        if (nPieceCheck * nPiece < 0)
        {
            nTakeLeft = nMoveLeft + 1;
            break;
        }
        if (nPieceCheck != 0) break;
        nMoveLeft = x;
        x++;
    }

    // check right
    x = 1;
    while (TRUE)
    {
        if (xStart + x > 7) break;
        nPieceCheck = (GetIntArray(oGM, "nSquare", yStart*8 + xStart+x));
        if (nPieceCheck * nPiece < 0)
        {
            nTakeRight = nMoveRight + 1;
            break;
        }
        if (nPieceCheck != 0) break;
        nMoveRight = x;
        x++;
    }

    // check if castling move is valid
    if (GetLocalInt(OBJECT_SELF, "bOriginalPos") == 1)
    {
        nTurn = GetLocalInt(oGM, "Turn");
        SetLocalInt(OBJECT_SELF, "castle", 1);
        if ((nPosition&7) == 0)
        {
            oKing = GetObjectArray(oGM, "oSquare", nPosition+4);
            if (GetIntArray(oGM, "nSquare", nPosition+1) != 0)
            {   SetLocalInt(OBJECT_SELF, "castle", 0);  }
            else if (GetIntArray(oGM, "nSquare", nPosition+2) != 0)
            {   SetLocalInt(OBJECT_SELF, "castle", 0);  }
            else if (GetIntArray(oGM, "nSquare", nPosition+3) != 0)
            {   SetLocalInt(OBJECT_SELF, "castle", 0);  }
            else if (GetLocalInt(oKing, "nPiece") != 6*nTurn)
            {   SetLocalInt(OBJECT_SELF, "castle", 0);  }
            else if (GetLocalInt(oKing, "bOriginalPos") == 0)
            {   SetLocalInt(OBJECT_SELF, "castle", 0);  }
        }
        else
        {
            oKing = GetObjectArray(oGM, "oSquare", nPosition-3);
            if (GetIntArray(oGM, "nSquare", nPosition-1) != 0)
            {   SetLocalInt(OBJECT_SELF, "castle", 0);  }
            else if (GetIntArray(oGM, "nSquare", nPosition-2) != 0)
            {   SetLocalInt(OBJECT_SELF, "castle", 0);  }
            else if (GetLocalInt(oKing, "nPiece") != 6*nTurn)
            {   SetLocalInt(OBJECT_SELF, "castle", 0);  }
            else if (GetLocalInt(oKing, "bOriginalPos") == 0)
            {   SetLocalInt(OBJECT_SELF, "castle", 0);  }
        }
    }
    else SetLocalInt(OBJECT_SELF, "castle", 0);

    if (nPiece > 0)
    {
        SetLocalInt(OBJECT_SELF, "moveforward", nMoveUp);
        SetLocalInt(OBJECT_SELF, "movebackward", nMoveDown);
        SetLocalInt(OBJECT_SELF, "moveleft", nMoveLeft);
        SetLocalInt(OBJECT_SELF, "moveright", nMoveRight);
        SetLocalInt(OBJECT_SELF, "takeforward", nTakeUp);
        SetLocalInt(OBJECT_SELF, "takebackward", nTakeDown);
        SetLocalInt(OBJECT_SELF, "takeleft", nTakeLeft);
        SetLocalInt(OBJECT_SELF, "takeright", nTakeRight);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "moveforward", nMoveDown);
        SetLocalInt(OBJECT_SELF, "movebackward", nMoveUp);
        SetLocalInt(OBJECT_SELF, "moveleft", nMoveRight);
        SetLocalInt(OBJECT_SELF, "moveright", nMoveLeft);
        SetLocalInt(OBJECT_SELF, "takeforward", nTakeDown);
        SetLocalInt(OBJECT_SELF, "takebackward", nTakeUp);
        SetLocalInt(OBJECT_SELF, "takeleft", nTakeRight);
        SetLocalInt(OBJECT_SELF, "takeright", nTakeLeft);
    }
}

void Move(int nMoveSpaces)
{
    int nPosition, nNewPosition;
    object oGM;

    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    oGM = GetNearestObjectByTag("gamemaster");
    switch (GetLocalInt(OBJECT_SELF, "movingdir"))
    {
    case 1:
        nNewPosition = nPosition + 8*nMoveSpaces;
        break;
    case 2:
        nNewPosition = nPosition - 8*nMoveSpaces;
        break;
    case 3:
        nNewPosition = nPosition - nMoveSpaces;
        break;
    case 4:
        nNewPosition = nPosition + nMoveSpaces;
        break;
    case 5:
        nNewPosition = nPosition + 7*nMoveSpaces;
        break;
    case 6:
        nNewPosition = nPosition + 9*nMoveSpaces;
        break;
    case 7:
        nNewPosition = nPosition - 9*nMoveSpaces;
        break;
    case 8:
        nNewPosition = nPosition - 7*nMoveSpaces;
    }

    if(GetObjectArray(oGM, "oSquare", nNewPosition) == oGM) MovePiece(nPosition, nNewPosition);
    else TakePiece(nPosition, nNewPosition);
}

void CheckKnight()
{
    int nPosition, nSide, nPiece, nPieceCheck, x, y;
    int mu2l1, mu2r1, mu1l2, mu1r2, md2l1, md2r1, md1l2, md1r2 = 0;
    int tu2l1, tu2r1, tu1l2, tu1r2, td2l1, td2r1, td1l2, td1r2 = 0;
    object oGM;

    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    oGM = GetNearestObjectByTag("gamemaster");
    nPiece = GetIntArray(oGM, "nSquare", nPosition);
    x = nPosition&7;
    y = nPosition>>3;

    nSide = GetLocalInt(oGM, "Turn");

    if ((y+1) < 8)
    {
        if ((x-2) > -1)
        {
            nPieceCheck = GetIntArray(oGM, "nSquare", nPosition + 6);
            if (nPieceCheck == 0) mu1l2 = 1;
            else if ((nPieceCheck*nSide) < 0) tu1l2 = 1;
        }
        if ((x+2) < 8)
        {
            nPieceCheck = GetIntArray(oGM, "nSquare", nPosition + 10);
            if (nPieceCheck == 0) mu1r2 = 1;
            else if ((nPieceCheck*nSide) < 0) tu1r2 = 1;
        }
        if ((y+2) < 8)
        {
            if ((x-1) > -1)
            {
                nPieceCheck = GetIntArray(oGM, "nSquare", nPosition + 15);
                if (nPieceCheck == 0) mu2l1 = 1;
                else if ((nPieceCheck*nSide) < 0) tu2l1 = 1;
            }
            if ((x+1) < 8)
            {
                nPieceCheck = GetIntArray(oGM, "nSquare", nPosition + 17);
                if (nPieceCheck == 0) mu2r1 = 1;
                else if ((nPieceCheck*nSide) < 0) tu2r1 = 1;
            }
        }
    }
    if ((y-1) > -1)
    {
        if ((x-2) > -1)
        {
            nPieceCheck = GetIntArray(oGM, "nSquare", nPosition - 10);
            if (nPieceCheck == 0) md1l2 = 1;
            else if ((nPieceCheck*nSide) < 0) td1l2 = 1;
        }
        if ((x+2) < 8)
        {
            nPieceCheck = GetIntArray(oGM, "nSquare", nPosition - 6);
            if (nPieceCheck == 0) md1r2 = 1;
            else if ((nPieceCheck*nSide) < 0) td1r2 = 1;
        }
        if ((y-2) > -1)
        {
            if ((x-1) > -1)
            {
                nPieceCheck = GetIntArray(oGM, "nSquare", nPosition - 17);
                if (nPieceCheck == 0) md2l1 = 1;
                else if ((nPieceCheck*nSide) < 0) td2l1 = 1;
            }
            if ((x+1) < 8)
            {
                nPieceCheck = GetIntArray(oGM, "nSquare", nPosition - 15);
                if (nPieceCheck == 0) md2r1 = 1;
                else if ((nPieceCheck*nSide) < 0) td2r1 = 1;
            }
        }
    }

    if (nSide == 1)
    {
        SetLocalInt(OBJECT_SELF, "movef2l1", mu2l1);
        SetLocalInt(OBJECT_SELF, "movef2r1", mu2r1);
        SetLocalInt(OBJECT_SELF, "movef1l2", mu1l2);
        SetLocalInt(OBJECT_SELF, "movef1r2", mu1r2);
        SetLocalInt(OBJECT_SELF, "moveb2l1", md2l1);
        SetLocalInt(OBJECT_SELF, "moveb2r1", md2r1);
        SetLocalInt(OBJECT_SELF, "moveb1l2", md1l2);
        SetLocalInt(OBJECT_SELF, "moveb1r2", md1r2);
        SetLocalInt(OBJECT_SELF, "takef2l1", tu2l1);
        SetLocalInt(OBJECT_SELF, "takef2r1", tu2r1);
        SetLocalInt(OBJECT_SELF, "takef1l2", tu1l2);
        SetLocalInt(OBJECT_SELF, "takef1r2", tu1r2);
        SetLocalInt(OBJECT_SELF, "takeb2l1", td2l1);
        SetLocalInt(OBJECT_SELF, "takeb2r1", td2r1);
        SetLocalInt(OBJECT_SELF, "takeb1l2", td1l2);
        SetLocalInt(OBJECT_SELF, "takeb1r2", td1r2);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "movef2l1", md2r1);
        SetLocalInt(OBJECT_SELF, "movef2r1", md2l1);
        SetLocalInt(OBJECT_SELF, "movef1l2", md1r2);
        SetLocalInt(OBJECT_SELF, "movef1r2", md1l2);
        SetLocalInt(OBJECT_SELF, "moveb2l1", mu2r1);
        SetLocalInt(OBJECT_SELF, "moveb2r1", mu2l1);
        SetLocalInt(OBJECT_SELF, "moveb1l2", mu1r2);
        SetLocalInt(OBJECT_SELF, "moveb1r2", mu1l2);
        SetLocalInt(OBJECT_SELF, "takef2l1", td2r1);
        SetLocalInt(OBJECT_SELF, "takef2r1", td2l1);
        SetLocalInt(OBJECT_SELF, "takef1l2", td1r2);
        SetLocalInt(OBJECT_SELF, "takef1r2", td1l2);
        SetLocalInt(OBJECT_SELF, "takeb2l1", tu2r1);
        SetLocalInt(OBJECT_SELF, "takeb2r1", tu2l1);
        SetLocalInt(OBJECT_SELF, "takeb1l2", tu1r2);
        SetLocalInt(OBJECT_SELF, "takeb1r2", tu1l2);
    }
}

int CheckForCheck(int nPos, int nSide)
{
    int x,y,xStart,yStart,nPiece;
    object oGM;

    oGM = GetNearestObjectByTag("gamemaster");
    xStart = nPos&7;
    yStart = nPos>>3;
    //check up-left
    x = xStart-1;
    y = yStart+1;
    while(TRUE)
    {
        if (x < 0 || y > 7) break;
        nPiece = GetIntArray(oGM, "nSquare", y*8 + x);
        if (nSide == 1)
        {
            //pawn check
            if ( x==xStart-1 && nPiece == -1 ) return y*8 + x;
        }
        //king check
        if ( x==xStart-1 && nPiece == nSide*(-6) ) return y*8 + x;
        //bishop/queen check
        if (nPiece == nSide*(-4) || nPiece == nSide*(-5)) return y*8 + x;
        //empty square check
        if (nPiece != 0) break;
        x--;
        y++;
    }

    //check up
    x = xStart;
    y = yStart+1;
    while(TRUE)
    {
        if (y > 7) break;
        nPiece = GetIntArray(oGM, "nSquare", y*8 + x);
        //king check
        if ( y==yStart+1 && nPiece == nSide*(-6) ) return y*8 + x;
        //rook/queen check
        if (nPiece == nSide*(-2) || nPiece == nSide*(-5)) return y*8 + x;
        //empty square check
        if (nPiece != 0) break;
        y++;
    }

    //check up-right
    x = xStart+1;
    y = yStart+1;
    while(TRUE)
    {
        if (x > 7 || y > 7) break;
        nPiece = GetIntArray(oGM, "nSquare", y*8 + x);
        if (nSide == 1)
        {
            //pawn check
            if ( x==xStart+1 && nPiece == nSide*-1 ) return y*8 + x;
        }
        //king check
        if ( x==xStart+1 && nPiece == nSide*(-6) ) return y*8 + x;
        //bishop/queen check
        if (nPiece == nSide*(-4) || nPiece == nSide*(-5)) return y*8 + x;
        //empty square check
        if (nPiece != 0) break;
        x++;
        y++;
    }

    //check left
    x = xStart-1;
    y = yStart;
    while(TRUE)
    {
        if (x < 0) break;
        nPiece = GetIntArray(oGM, "nSquare", y*8 + x);
        //king check
        if ( x==xStart-1 && nPiece == nSide*(-6) ) return y*8 + x;
        //rook/queen check
        if (nPiece == nSide*(-2) || nPiece == nSide*(-5)) return y*8 + x;
        //empty square check
        if (nPiece != 0) break;
        x--;
    }

    //check right
    x = xStart+1;
    y = yStart;
    while(TRUE)
    {
        if (x > 7) break;
        nPiece = GetIntArray(oGM, "nSquare", y*8 + x);
        //king check
        if ( x==xStart+1 && nPiece == nSide*(-6) ) return y*8 + x;
        //rook/queen check
        if (nPiece == nSide*(-2) || nPiece == nSide*(-5)) return y*8 + x;
        //empty square check
        if (nPiece != 0) break;
        x++;
    }

    //check down-left
    x = xStart-1;
    y = yStart-1;
    while(TRUE)
    {
        if (x < 0 || y < 0) break;
        nPiece = GetIntArray(oGM, "nSquare", y*8 + x);
        if (nSide == -1)
        {
            //pawn check
            if ( x==xStart-1 && nPiece == 1 ) return y*8 + x;
        }
        //king check
        if ( x==xStart-1 && nPiece == nSide*(-6) ) return y*8 + x;
        //bishop/queen check
        if (nPiece == nSide*(-4) || nPiece == nSide*(-5)) return y*8 + x;
        //empty square check
        if (nPiece != 0) break;
        x--;
        y--;
    }

    //check down
    x = xStart;
    y = yStart-1;
    while(TRUE)
    {
        if (y < 0) break;
        nPiece = GetIntArray(oGM, "nSquare", y*8 + x);
        //king check
        if ( y==yStart-1 && nPiece == nSide*(-6) ) return y*8 + x;
        //rook/queen check
        if (nPiece == nSide*(-2) || nPiece == nSide*(-5)) return y*8 + x;
        //empty square check
        if (nPiece != 0) break;
        y--;
    }

    //check down-right
    x = xStart+1;
    y = yStart-1;
    while(TRUE)
    {
        if (x > 7 || y < 0) break;
        nPiece = GetIntArray(oGM, "nSquare", y*8 + x);
        if (nSide == -1)
        {
            //pawn check
            if ( x==xStart+1 && nPiece == 1 ) return y*8 + x;
        }
        //king check
        if ( x==xStart+1 && nPiece == nSide*(-6) ) return y*8 + x;
        //bishop/queen check
        if (nPiece == nSide*(-4) || nPiece == nSide*(-5)) return y*8 + x;
        //empty square check
        if (nPiece != 0) break;
        x++;
        y--;
    }

    //check to see if knights are putting king in check
    if (xStart > 1 && yStart < 7)
    {
        nPiece = GetIntArray(oGM, "nSquare", (yStart+1)*8+xStart-2);
        if (nPiece == nSide*(-3)) return (yStart+1)*8+xStart-2;
    }
    if (xStart > 0 && yStart < 6)
    {
        nPiece = GetIntArray(oGM, "nSquare", (yStart+2)*8+xStart-1);
        if (nPiece == nSide*(-3)) return (yStart+2)*8+xStart-1;
    }
    if (xStart < 7 && yStart < 6)
    {
        nPiece = GetIntArray(oGM, "nSquare", (yStart+2)*8+xStart+1);
        if (nPiece == nSide*(-3)) return (yStart+2)*8+xStart+1;
    }
    if (xStart < 6 && yStart < 7)
    {
        nPiece = GetIntArray(oGM, "nSquare", (yStart+1)*8+xStart+2);
        if (nPiece == nSide*(-3)) return (yStart+1)*8+xStart+2;
    }
    if (xStart > 1 && yStart > 0)
    {
        nPiece = GetIntArray(oGM, "nSquare", (yStart-1)*8+xStart-2);
        if (nPiece == nSide*(-3)) return (yStart-1)*8+xStart-2;
    }
    if (xStart > 0 && yStart > 1)
    {
        nPiece = GetIntArray(oGM, "nSquare", (yStart-2)*8+xStart-1);
        if (nPiece == nSide*(-3)) return (yStart-2)*8+xStart-1;
    }
    if (xStart < 7 && yStart > 1)
    {
        nPiece = GetIntArray(oGM, "nSquare", (yStart-2)*8+xStart+1);
        if (nPiece == nSide*(-3)) return (yStart-2)*8+xStart+1;
    }
    if (xStart < 6 && yStart > 0)
    {
        nPiece = GetIntArray(oGM, "nSquare", (yStart-1)*8+xStart+2);
        if (nPiece == nSide*(-3)) return (yStart-1)*8+xStart+2;
    }

    return 0;
}

// return values:
//   0 = no checkmate or stalemate
//   1 = checkmate
//   2 = stalemate
int CheckForCheckMate()
{
    int nTurn, nKingPos, nKingPos1, nKingPos2, nxKing, nyKing, nKingPiece, nTemp, x, y, z, dx, dy, nCheck;
    object oGM, oTemp;
    int nCheckerPos, nCheckerPiece, nxChecker, nyChecker;

    oGM = GetNearestObjectByTag("gamemaster");
    nTurn = GetLocalInt(oGM, "Turn");

    //find king
    nKingPos = 0;
    while(TRUE)
    {
        nTemp = GetIntArray(oGM, "nSquare", nKingPos);
        if (nTemp == nTurn*6) break;
        nKingPos++;
    }
    nKingPiece=nTemp;

    //can any of this team's other pieces move anywhere?
    nCheck = 0;
    x = 0;
    while ((x < 64) && (nCheck == 0))
    {
        nTemp = GetIntArray(oGM, "nSquare", x);
        if (nTurn * nTemp > 0)
        {
            oTemp = GetObjectArray(oGM, "oSquare", x);
            switch(abs(nTemp))
            {
                case 1:
                {
                    ExecuteScript("CHECKPAWN", oTemp);
                    if (GetLocalInt(oTemp, "moveforwardone") == 1 ||
                        GetLocalInt(oTemp, "moveforwardtwo") == 1 ||
                        GetLocalInt(oTemp, "takeforwardleft") == 1 ||
                        GetLocalInt(oTemp, "takeforwardright") == 1 ||
                        GetLocalInt(oTemp, "enpassantleft") == 1 ||
                        GetLocalInt(oTemp, "enpassantright") == 1)
                    {
                        nCheck = 1;
                    }
                    break;
                }
                case 2:
                {
                    ExecuteScript("CHECKROOK", oTemp);
                    if (GetLocalInt(oTemp, "moveforward") > 0 ||
                        GetLocalInt(oTemp, "movebackward") > 0 ||
                        GetLocalInt(oTemp, "moveleft") > 0 ||
                        GetLocalInt(oTemp, "moveright") > 0 ||
                        GetLocalInt(oTemp, "takeforward") > 0 ||
                        GetLocalInt(oTemp, "takebackward") > 0 ||
                        GetLocalInt(oTemp, "takeleft") > 0 ||
                        GetLocalInt(oTemp, "takeright") > 0)
                    {
                        nCheck = 1;
                    }
                    if(GetLocalInt(oTemp, "castle") == 1)
                    {
                        if ((x&7) == 0)
                        {
                            nKingPos = x+4;
                            nKingPos1 = x+3;
                            nKingPos2 = x+2;
                        }
                        else
                        {
                            nKingPos = x-3;
                            nKingPos1 = x-2;
                            nKingPos2 = x-1;
                        }
                        if (!CheckForCheck(nKingPos, nTurn))
                        {
                            SetIntArray(oGM, "nSquare", nKingPos, 0);
                            SetIntArray(oGM, "nSquare", nKingPos1, 6*nTurn);
                            if (!CheckForCheck(nKingPos1, nTurn))
                            {
                                SetIntArray(oGM, "nSquare", nKingPos1, 0);
                                SetIntArray(oGM, "nSquare", nKingPos2, 6*nTurn);
                                if (!CheckForCheck(nKingPos2, nTurn))
                                {
                                    nCheck = 1;
                                }
                                SetIntArray(oGM, "nSquare", nKingPos2, 0);
                            }
                            SetIntArray(oGM, "nSquare", nKingPos, 6*nTurn);
                            SetIntArray(oGM, "nSquare", nKingPos1, 0);
                        }
                    }
                    break;
                }
                case 3:
                {
                    ExecuteScript("CHECKKNIGHT", oTemp);
                    if (GetLocalInt(oTemp, "movef2l1") == 1 ||
                        GetLocalInt(oTemp, "movef2r1") == 1 ||
                        GetLocalInt(oTemp, "movef1l2") == 1 ||
                        GetLocalInt(oTemp, "movef1r2") == 1 ||
                        GetLocalInt(oTemp, "moveb2l1") == 1 ||
                        GetLocalInt(oTemp, "moveb2r1") == 1 ||
                        GetLocalInt(oTemp, "moveb1l2") == 1 ||
                        GetLocalInt(oTemp, "moveb1r2") == 1 ||
                        GetLocalInt(oTemp, "takef2l1") == 1 ||
                        GetLocalInt(oTemp, "takef2r1") == 1 ||
                        GetLocalInt(oTemp, "takef1l2") == 1 ||
                        GetLocalInt(oTemp, "takef1r2") == 1 ||
                        GetLocalInt(oTemp, "takeb2l1") == 1 ||
                        GetLocalInt(oTemp, "takeb2r1") == 1 ||
                        GetLocalInt(oTemp, "takeb1l2") == 1 ||
                        GetLocalInt(oTemp, "takeb1r2") == 1)
                    {
                        nCheck = 1;
                    }
                    break;
                }
                case 4:
                {
                    ExecuteScript("CHECKBISHOP", oTemp);
                    if(GetLocalInt(oTemp, "move_fl") > 0 ||
                       GetLocalInt(oTemp, "move_fr") > 0 ||
                       GetLocalInt(oTemp, "move_bl") > 0 ||
                       GetLocalInt(oTemp, "move_br") > 0 ||
                       GetLocalInt(oTemp, "take_fl") > 0 ||
                       GetLocalInt(oTemp, "take_fr") > 0 ||
                       GetLocalInt(oTemp, "take_bl") > 0 ||
                       GetLocalInt(oTemp, "take_br") > 0)
                    {
                        nCheck = 1;
                    }
                    break;
                }
                case 5:
                {
                    ExecuteScript("CHECKROOK", oTemp);
                    if (GetLocalInt(oTemp, "moveforward") > 0 ||
                        GetLocalInt(oTemp, "movebackward") > 0 ||
                        GetLocalInt(oTemp, "moveleft") > 0 ||
                        GetLocalInt(oTemp, "moveright") > 0 ||
                        GetLocalInt(oTemp, "takeforward") > 0 ||
                        GetLocalInt(oTemp, "takebackward") > 0 ||
                        GetLocalInt(oTemp, "takeleft") > 0 ||
                        GetLocalInt(oTemp, "takeright") > 0)
                    {
                        nCheck = 1;
                    }
                    if (nCheck == 1) break;
                    ExecuteScript("CHECKBISHOP", oTemp);
                    if(GetLocalInt(oTemp, "move_fl") > 0 ||
                       GetLocalInt(oTemp, "move_fr") > 0 ||
                       GetLocalInt(oTemp, "move_bl") > 0 ||
                       GetLocalInt(oTemp, "move_br") > 0 ||
                       GetLocalInt(oTemp, "take_fl") > 0 ||
                       GetLocalInt(oTemp, "take_fr") > 0 ||
                       GetLocalInt(oTemp, "take_bl") > 0 ||
                       GetLocalInt(oTemp, "take_br") > 0)
                    {
                        nCheck = 1;
                    }
                    break;
                }
            }
        }
        x++;
    }

    //if another piece can move and if king is not in check, return 0
    nCheckerPos = CheckForCheck(nKingPos, nTurn);
    if (!nCheckerPos && nCheck == 1) return 0;

    nxKing = nKingPos&7;
    nyKing = nKingPos>>3;
    //can king move up-left
    if (nxKing > 0 && nyKing < 7)
    {
        nTemp = GetIntArray(oGM, "nSquare", nKingPos+7);
        if (nTemp*nTurn <= 0)
        {
            if(!KingInCheckAfterMove(nKingPos, nKingPos+7, nKingPiece, nTurn)) return 0;
        }
    }

    //can king move up
    if (nyKing < 7)
    {
        nTemp = GetIntArray(oGM, "nSquare", nKingPos+8);
        if (nTemp*nTurn <= 0)
        {
            if(!KingInCheckAfterMove(nKingPos, nKingPos+8, nKingPiece, nTurn)) return 0;
        }
    }

    //can king move up-right
    if (nxKing < 7 && nyKing < 7)
    {
        nTemp = GetIntArray(oGM, "nSquare", nKingPos+9);
        if (nTemp*nTurn <= 0)
        {
            if(!KingInCheckAfterMove(nKingPos, nKingPos+9, nKingPiece, nTurn)) return 0;
        }
    }

    //can king move left
    if (nxKing > 0)
    {
        nTemp = GetIntArray(oGM, "nSquare", nKingPos-1);
        if (nTemp*nTurn <= 0)
        {
            if(!KingInCheckAfterMove(nKingPos, nKingPos-1, nKingPiece, nTurn)) return 0;
        }
    }

    //can king move right
    if (nxKing < 7)
    {
        nTemp = GetIntArray(oGM, "nSquare", nKingPos+1);
        if (nTemp*nTurn <= 0)
        {
            if(!KingInCheckAfterMove(nKingPos, nKingPos+1, nKingPiece, nTurn)) return 0;
        }
    }

    //can king move down-left
    if (nxKing > 0 && nyKing > 0)
    {
        nTemp = GetIntArray(oGM, "nSquare", nKingPos-9);
        if (nTemp*nTurn <= 0)
        {
            if(!KingInCheckAfterMove(nKingPos, nKingPos-9, nKingPiece, nTurn)) return 0;
        }
    }

    //can king move down
    if (nyKing > 0)
    {
        nTemp = GetIntArray(oGM, "nSquare", nKingPos-8);
        if (nTemp*nTurn <= 0)
        {
            if(!KingInCheckAfterMove(nKingPos, nKingPos-8, nKingPiece, nTurn)) return 0;
        }
    }

    //can king move down-right
    if (nxKing < 7 && nyKing > 0)
    {
        nTemp = GetIntArray(oGM, "nSquare", nKingPos-7);
        if (nTemp*nTurn <= 0)
        {
            if(!KingInCheckAfterMove(nKingPos, nKingPos-7, nKingPiece, nTurn)) return 0;
        }
    }

    //If I haven't returned yet, then the king cannot move without being in check.
    //If no other piece can move, it's checkmate if the king is in check,
    //and stalemate if the king is not in check.
    if (nCheck == 0)
    {
        if (!nCheckerPos) return 2; else return 1;
    }

    //can any of the pieces get the king out of check?
    while(TRUE)
    {
        nCheckerPiece = GetIntArray(oGM, "nSquare", nCheckerPos);
        nxChecker = nCheckerPos&7;
        nyChecker = nCheckerPos>>3;
        if (nCheckerPiece*nTurn <= 0)
        {
            for (z = 0; z < 64; z++)
            {
                nTemp = GetIntArray(oGM, "nSquare", z);
                switch(nTemp*nTurn)
                {
                    case 1:
                    {
                        if (nCheckerPos == (z+7*nTurn) || nCheckerPos == (z+9*nTurn))
                        {
                            SetIntArray(oGM, "nSquare", z, 0);
                            SetIntArray(oGM, "nSquare", nCheckerPos, nTemp);
                            nCheck = CheckForCheck(nKingPos, nTurn);
                            SetIntArray(oGM, "nSquare", z, nTemp);
                            SetIntArray(oGM, "nSquare", nCheckerPos, nCheckerPiece);
                            if (nCheck == 0) return 0;
                        }
                        break;
                    }
                    case 5:
                    case 2:
                    {
                        x = z&7;
                        y = z>>3;

                        if ( (nxChecker == x) || (nyChecker == y) )
                        {
                            if(x == nxChecker)
                            {
                                dx = 0;
                                if (y > nyChecker) dy = -1;
                                else dy = 1;
                            }
                            if(y == nyChecker)
                            {
                                dy = 0;
                                if (x > nxChecker) dx = -1;
                                else dx = 1;
                            }
                            while (TRUE)
                            {
                                x += dx;
                                y += dy;
                                if (x == nxChecker && y == nyChecker)
                                {
                                    SetIntArray(oGM, "nSquare", z, 0);
                                    SetIntArray(oGM, "nSquare", nCheckerPos, nTemp);
                                    nCheck = CheckForCheck(nKingPos, nTurn);
                                    SetIntArray(oGM, "nSquare", z, nTemp);
                                    SetIntArray(oGM, "nSquare", nCheckerPos, nCheckerPiece);
                                    if (nCheck == 0) return 0;
                                }
                                if (GetIntArray(oGM, "nSquare", y*8+x) != 0) break;
                            }
                        }
                        if (nTemp*nTurn == 2) break;
                    }
                    case 4:
                    {
                        x = z&7;
                        y = z>>3;

                        if ( (nxChecker - x == nyChecker - y) || (nxChecker + x == nyChecker - y) )
                        {
                            if(nxChecker > x) dx = 1;
                            else dx = -1;
                            if(nyChecker > y) dy = 1;
                            else dy = -1;
                            while (TRUE)
                            {
                                x += dx;
                                y += dy;
                                if (x == nxChecker)
                                {
                                    SetIntArray(oGM, "nSquare", z, 0);
                                    SetIntArray(oGM, "nSquare", nCheckerPos, nTemp);
                                    nCheck = CheckForCheck(nKingPos, nTurn);
                                    SetIntArray(oGM, "nSquare", z, nTemp);
                                    SetIntArray(oGM, "nSquare", nCheckerPos, nCheckerPiece);
                                    if (nCheck == 0) return 0;
                                }
                                if (GetIntArray(oGM, "nSquare", y*8+x) != 0) break;
                            }
                        }
                        break;
                    }
                    case 3:
                    {
                        if (nCheckerPos == (z+6) || nCheckerPos == (z+10) ||
                            nCheckerPos == (z+15) || nCheckerPos == (z+17) ||
                            nCheckerPos == (z-6) || nCheckerPos == (z-10) ||
                            nCheckerPos == (z-15) || nCheckerPos == (z-17))
                        {
                            SetIntArray(oGM, "nSquare", z, 0);
                            SetIntArray(oGM, "nSquare", nCheckerPos, nTemp);
                            nCheck = CheckForCheck(nKingPos, nTurn);
                            SetIntArray(oGM, "nSquare", z, nTemp);
                            SetIntArray(oGM, "nSquare", nCheckerPos, nCheckerPiece);
                            if (nCheck == 0) return 0;
                        }
                        break;
                    }
                }
            }
        }
        if (nCheckerPiece == (-3)*nTurn || nCheckerPiece == (-1)*nTurn) break;

        if (nxChecker > nxKing) nxChecker--;
        else if (nxChecker < nxKing) nxChecker++;

        if (nyChecker > nyKing) nyChecker--;
        else if (nyChecker < nyKing) nyChecker++;

        nCheckerPos = nyChecker*8 + nxChecker;
        if (nCheckerPos == nKingPos) break;
    };
    return 1;
}

string MovePositions(int nStartPos, int nEndPos)
{
    object oGM = GetNearestObjectByTag("gamemaster");
    string sTemp;
    if ( (nStartPos>63) || (nStartPos<0) || (nEndPos>63) || (nEndPos<0) )
        sTemp = "If you're reading this, something's wrong.";
    else
    {
        sTemp = sTemp+GetStringArray(oGM, "sNotation", nStartPos);
        sTemp = sTemp+"-"+GetStringArray(oGM, "sNotation", nEndPos);
    }
    return sTemp;
}

void StartFight(object oTarget)
{
    SetLocalObject(OBJECT_SELF, "target", oTarget);
    SetLocalObject(oTarget, "attacker", OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "fighting", 1);
    SetLocalInt(oTarget, "fighting", 2);
    SetLocalInt(GetNearestObjectByTag("gamemaster"), "piecefight", 1);
    SetPlotFlag(oTarget, FALSE);
    // Set hp of target to 1, to keep fights short.
    // Comment out the next line if you prefer to keep the actual hp of the piece creatures.
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oTarget)-1), oTarget);
    DelayCommand(0.2, ContinueFight(oTarget, TRUE));
    object oMe = OBJECT_SELF;
    DelayCommand(0.2, AssignCommand(oTarget, ContinueFight(oMe, FALSE)));
}

void ContinueFight(object oTarget, int bAggressor)
{
    // I could do all kinds of cool stuff here, like checking to see which piece is attacking
    // and changing the attacks accordingly (ie. bishop casts a certain spell or whatever)
    // For now though I've kept things simple.
    // I also have it set up that separate checks can be done depending on whether the
    // piece is attacking or defending.

    if (!bAggressor) // defender
    {
        ClearAllActions();
        // Make sure the attacker still isn't in conversation.
        // ** WARNING ** All piece-fighting scripting needs to be INSIDE
        // the following if statement.
        // This is to ensure that pawn promotion doesn't get screwed up.
        if(!IsInConversation(oTarget))
        {
            SetIsTemporaryEnemy(oTarget, OBJECT_SELF, FALSE, 10.0);
            ActionAttack(oTarget, TRUE);
        }
    }
    else // attacker
    {
        ClearAllActions();
        // Make sure the attacker still isn't in conversation.
        // ** WARNING ** All piece-fighting scripting needs to be INSIDE
        // the following if statement.
        // This is to ensure that pawn promotion doesn't get screwed up.
        if(!IsInConversation(OBJECT_SELF))
        {
            SetIsTemporaryEnemy(oTarget, OBJECT_SELF, FALSE, 10.0);

            // Cast a spell if the attacker is a Bishop
            if (GetTag(OBJECT_SELF) == "bishop_b")
                CastSpell(oTarget, BLACK);
            else if (GetTag(OBJECT_SELF) == "bishop_w")
                CastSpell(oTarget, WHITE);
            else  // Not a bishop, attack
                ActionAttack(oTarget);
        }
    }
}


int KingInCheckAfterMove(int nPosition, int nNewPosition, int nPiece, int nSide)
{
    object oGM=GetNearestObjectByTag("gamemaster");
    int nNewPositionPiece = GetIntArray(oGM, "nSquare", nNewPosition);
    int nCheck;

    SetIntArray(oGM, "nSquare", nNewPosition, nPiece);
    SetIntArray(oGM, "nSquare", nPosition, 0);
    nCheck = CheckForCheck(nNewPosition, nSide);
    SetIntArray(oGM, "nSquare", nNewPosition, nNewPositionPiece);
    SetIntArray(oGM, "nSquare", nPosition, nPiece);
    if (nCheck==0) return FALSE; else return TRUE;
}

void PromotePawn(string sNewPiece, int nNewPiece)
{
    object oGM, oTemp;
    location lLoc;
    int nPosition;
    int nKingPos, nTemp, nTurn, nCheckMate;

    oGM = GetNearestObjectByTag("gamemaster");
    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    lLoc = GetLocationArray(oGM, "lSquare", nPosition);
    if (GetLocalInt(OBJECT_SELF, "nPiece") > 0)
    {
        oTemp = CreateObject(OBJECT_TYPE_CREATURE, sNewPiece+"_w", lLoc);
        SetIntArray(oGM, "nSquare", nPosition, nNewPiece);
    }
    else
    {
        oTemp = CreateObject(OBJECT_TYPE_CREATURE, sNewPiece+"_b", lLoc);
        SetIntArray(oGM, "nSquare", nPosition, (-nNewPiece));
    }
    SetLocalInt(oTemp, "nPosition", nPosition);
    SetObjectArray(oGM, "oSquare", nPosition, oTemp);
    SetLocalObject(oTemp, "target", GetLocalObject(OBJECT_SELF, "target"));
    SetLocalObject(GetLocalObject(OBJECT_SELF, "target"), "attacker", oTemp);
    SetLocalInt(oTemp, "fighting", 1);

    ExecuteScript("heartbeat", oTemp);

    nCheckMate=CheckForCheckMate();
    if(nCheckMate==2)
    {
        AssignCommand(oGM,ActionSpeakString("Stalemate!", TALKVOLUME_SHOUT));
        SetLocalInt(oGM, "GameState", 3);
    }
    else if(nCheckMate==1)
    {
        AssignCommand(oGM,ActionSpeakString("Checkmate!", TALKVOLUME_SHOUT));
        SetLocalInt(oGM, "GameState", 3);

        // SPECIAL CHECKMATE SCRIPT
        //find opposing king
        object oCenter = GetObjectByTag("centerpoint");
        location lLoc = GetLocation(oCenter);

        nKingPos = 0;
        while(TRUE)
        {
            nTemp = GetIntArray(oGM, "nSquare", nKingPos);
            if (nTemp == nTurn*6) break;
            nKingPos++;
        }

        // Get the losing king object, what a dope.
        object oFailedKing = GetObjectArray(oGM, "oSquare", nKingPos);
        object oBlackKing = GetObjectByTag("king_b");
        // oWhiteKing is unnecessary
        // object oWhiteKing = GetObjectByTag("king_w");
        object oDragon;
        effect eEffect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

        // Make the king killable
        SetPlotFlag(oFailedKing, FALSE);

        // May as well create some mayhem and let everyone get whacked
        int x;
        object oPiece,oTarget;
        for (x=0;x<64;x++)
        {
            oPiece = GetObjectArray(oGM, "oSquare", x);
            oTarget = GetLocalObject(oPiece, "target");
            if(GetIsObjectValid(oTarget)) SetPlotFlag(oTarget, FALSE);
            if(oPiece!=oGM && GetIsObjectValid(oPiece)) SetPlotFlag(oPiece, FALSE);
        }

        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eEffect, lLoc, 15.0);

        // Create a dragon of the winners color to kill their king.
        if (GetReputation(OBJECT_SELF, oBlackKing) == 0)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "whitedragon", lLoc);
            oDragon = GetObjectByTag("WhiteDragon");
        }
        else
        {
            CreateObject(OBJECT_TYPE_CREATURE, "blackdragon", lLoc);
            oDragon = GetObjectByTag("BlackDragon");
        }

        AssignCommand(oDragon, ActionSpeakString("Checkmate!", TALKVOLUME_SHOUT));
        DelayCommand(2.0, AssignCommand(oDragon,  ActionAttack(oFailedKing)));
        // END SPECIAL CHECKMATE SCRIPT
    }
    else
    {
        //find opposing king
        nTurn = GetLocalInt(oGM, "Turn");
        nKingPos = 0;
        while(TRUE)
        {
            nTemp = GetIntArray(oGM, "nSquare", nKingPos);
            if (nTemp == nTurn*6) break;
            nKingPos++;
        }

        if (CheckForCheck(nKingPos, nTurn)) AssignCommand(oTemp, SpeakString("Check!", TALKVOLUME_SHOUT));
    }
    DestroyObject(OBJECT_SELF);
    return;
}

void CastSpell(object oTarget, int nColor)
{
    int nSpell;
    int nRand = Random(4);

    if ( nColor == BLACK )
    {
        switch (nRand)
        {
            case 0:
                nSpell = SPELL_BURNING_HANDS;
                break;
            case 1:
                nSpell = SPELL_VAMPIRIC_TOUCH;
                break;
            case 2:
                nSpell = SPELL_FIREBALL;
                break;
            case 3:
                nSpell = SPELL_METEOR_SWARM;
        }
    }

    else // must be white
    {
        switch (nRand)
        {
            case 0:
                nSpell = SPELL_RAY_OF_FROST;
                break;
            case 1:
                nSpell = SPELL_LIGHTNING_BOLT;
                break;
            case 2:
                nSpell =  SPELL_CALL_LIGHTNING;
                break;
            case 3:
                nSpell = SPELL_ICE_STORM;
        }
    }

    // Cast the spell
    ActionCastSpellAtObject(nSpell, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
}
