#include "chessinc"

void main()
{
    int nRookPos, nTurn, nKingPos, nKingPos1, nKingPos2, nTemp, nCheckMate;
    object oGM, oRook;

    oGM = GetNearestObjectByTag("gamemaster");
    nTurn = GetLocalInt(oGM, "Turn");

    nKingPos = GetLocalInt(OBJECT_SELF, "nPosition");
    nKingPos1 = nKingPos-1;
    nKingPos2 = nKingPos-2;
    nRookPos = nKingPos-4;

    if (CheckForCheck(nKingPos, nTurn)) ActionSpeakString("Sorry, can't castle out of check.");
    else
    {
        SetIntArray(oGM, "nSquare", nKingPos, 0);
        SetIntArray(oGM, "nSquare", nKingPos1, 6*nTurn);
        if (CheckForCheck(nKingPos1, nTurn))
        {
            SetIntArray(oGM, "nSquare", nKingPos, 6*nTurn);
            SetIntArray(oGM, "nSquare", nKingPos1, 0);
            ActionSpeakString("Sorry, can't castle through check.");
        }
        else
        {
            SetIntArray(oGM, "nSquare", nKingPos1, 0);
            SetIntArray(oGM, "nSquare", nKingPos2, 6*nTurn);
            if (CheckForCheck(nKingPos2, nTurn))
            {
                SetIntArray(oGM, "nSquare", nKingPos, 6*nTurn);
                SetIntArray(oGM, "nSquare", nKingPos2, 0);
                ActionSpeakString("Sorry, can't castle into check.");
            }
            else
            {
                SetIntArray(oGM, "nSquare", nRookPos, 0);
                SetIntArray(oGM, "nSquare", nKingPos1, 2*nTurn);
                ActionJumpToLocation(GetLocationArray(oGM, "lSquare", nKingPos2));
                SetObjectArray(oGM, "oSquare", nKingPos, oGM);
                SetObjectArray(oGM, "oSquare", nKingPos2, OBJECT_SELF);
                SetLocalInt(OBJECT_SELF, "nPosition", nKingPos2);

                oRook = GetObjectArray(oGM, "oSquare", nRookPos);
                AssignCommand(oRook, ActionJumpToLocation(GetLocationArray(oGM, "lSquare", nKingPos1)));
                SetObjectArray(oGM, "oSquare", nRookPos, oGM);
                SetObjectArray(oGM, "oSquare", nKingPos1, oRook);
                SetLocalInt(oRook, "nPosition", nKingPos1);

                nTurn = nTurn * (-1);
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
            }
        }
    }
}
