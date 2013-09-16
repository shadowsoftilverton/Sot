#include "chessinc"

void main()
{
    int nPosition, nTurn, nKingPos, nKingPos1, nKingPos2, nTemp, nCheckMate;
    object oGM, oKing;

    oGM = GetNearestObjectByTag("gamemaster");
    nTurn = GetLocalInt(oGM, "Turn");

    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    if ((nPosition&7) == 0)
    {
        nKingPos = nPosition+4;
        nKingPos1 = nPosition+3;
        nKingPos2 = nPosition+2;
    }
    else
    {
        nKingPos = nPosition-3;
        nKingPos1 = nPosition-2;
        nKingPos2 = nPosition-1;
    }

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
                SetIntArray(oGM, "nSquare", nPosition, 0);
                SetIntArray(oGM, "nSquare", nKingPos1, 2*nTurn);
                oKing = GetObjectArray(oGM, "oSquare", nKingPos);
                AssignCommand(oKing, ActionJumpToLocation(GetLocationArray(oGM, "lSquare", nKingPos2)));
                SetObjectArray(oGM, "oSquare", nKingPos, oGM);
                SetObjectArray(oGM, "oSquare", nKingPos2, oKing);
                SetLocalInt(oKing, "nPosition", nKingPos2);

                ActionJumpToLocation(GetLocationArray(oGM, "lSquare", nKingPos1));
                SetObjectArray(oGM, "oSquare", nPosition, oGM);
                SetObjectArray(oGM, "oSquare", nKingPos1, OBJECT_SELF);
                SetLocalInt(OBJECT_SELF, "nPosition", nKingPos1);

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

/*
    if ((nPosition&7) == 0)
    {
        if (CheckForCheck(nPosition + 4, nTurn)) ActionSpeakString("Sorry, can't castle out of check.");
        else
        {
            SetIntArray(oGM, "nSquare", nPosition + 4, 0);
            SetIntArray(oGM, "nSquare", nPosition + 3, 6*nTurn);
            if (CheckForCheck(nPosition + 3, nTurn))
            {
                SetIntArray(oGM, "nSquare", nPosition + 4, 6*nTurn);
                SetIntArray(oGM, "nSquare", nPosition + 3, 0);
                ActionSpeakString("Sorry, can't castle through check.");
            }
            else
            {
                SetIntArray(oGM, "nSquare", nPosition + 3, 0);
                SetIntArray(oGM, "nSquare", nPosition + 2, 6*nTurn);
                if (CheckForCheck(nPosition + 2, nTurn))
                {
                    SetIntArray(oGM, "nSquare", nPosition + 4, 6*nTurn);
                    SetIntArray(oGM, "nSquare", nPosition + 2, 0);
                    ActionSpeakString("Sorry, can't castle into check.");
                }
                else
                {
                    SetIntArray(oGM, "nSquare", nPosition, 0);
                    SetIntArray(oGM, "nSquare", nPosition + 3, 2*nTurn);
                    oKing = GetObjectArray(oGM, "oSquare", nPosition + 4);
                    AssignCommand(oKing, ActionJumpToLocation(GetLocationArray(oGM, "lSquare", nPosition + 2)));
                    SetObjectArray(oGM, "oSquare", nPosition + 4, oGM);
                    SetObjectArray(oGM, "oSquare", nPosition + 2, oKing);
                    SetLocalInt(oKing, "nPosition", nPosition + 2);

                    ActionJumpToLocation(GetLocationArray(oGM, "lSquare", nPosition + 3));
                    SetObjectArray(oGM, "oSquare", nPosition, oGM);
                    SetObjectArray(oGM, "oSquare", nPosition + 3, OBJECT_SELF);
                    SetLocalInt(OBJECT_SELF, "nPosition", nPosition + 3);

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
    else
    {
        if (CheckForCheck(nPosition - 3, nTurn)) ActionSpeakString("Sorry, can't castle out of check.");
        else
        {
            SetIntArray(oGM, "nSquare", nPosition - 3, 0);
            SetIntArray(oGM, "nSquare", nPosition - 1, 6*nTurn);
            SetIntArray(oGM, "nSquare", nPosition, 0);
            SetIntArray(oGM, "nSquare", nPosition - 2, 2*nTurn);
            if (CheckForCheck(nPosition - 1, nTurn))
            // if moving stuff puts king in check, put stuff back
            {
                SetIntArray(oGM, "nSquare", nPosition - 3, 6*nTurn);
                SetIntArray(oGM, "nSquare", nPosition - 1, 0);
                SetIntArray(oGM, "nSquare", nPosition, 2*nTurn);
                SetIntArray(oGM, "nSquare", nPosition - 2, 0);
                ActionSpeakString("Nope, king will be in check if I do that!");
            }
            else
            {
                oKing = GetObjectArray(oGM, "oSquare", nPosition - 3);
                AssignCommand(oKing, ActionJumpToLocation(GetLocationArray(oGM, "lSquare", nPosition - 1)));
                SetObjectArray(oGM, "oSquare", nPosition - 3, oGM);
                SetObjectArray(oGM, "oSquare", nPosition - 1, oKing);
                SetLocalInt(oKing, "nPosition", nPosition - 1);

                ActionJumpToLocation(GetLocationArray(oGM, "lSquare", nPosition - 2));
                SetObjectArray(oGM, "oSquare", nPosition, oGM);
                SetObjectArray(oGM, "oSquare", nPosition - 2, OBJECT_SELF);
                SetLocalInt(OBJECT_SELF, "nPosition", nPosition - 2);

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
*/
}
