#include "chessinc"

void main()
{
    int nPosition, nPiece;
    location lLoc;
    object oGM, oTarget;
    vector vMyself, vTarget, vDiff;

    switch(GetLocalInt(OBJECT_SELF, "fighting"))
    {
        case 2:
            oTarget = GetLocalObject(OBJECT_SELF, "attacker");
            ContinueFight(oTarget, FALSE);
            break;
        case 1:
            oTarget = GetLocalObject(OBJECT_SELF, "target");
            if (GetIsObjectValid(oTarget))
            {
                ContinueFight(oTarget, TRUE);
                break;
            }
            else
            {
                ClearAllActions();
                SetLocalInt(OBJECT_SELF, "fighting", 0);
                DeleteLocalObject(OBJECT_SELF, "target");
            }
        case 0:
            nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
            oGM = GetNearestObjectByTag("gamemaster");
            lLoc = GetLocationArray(oGM, "lSquare", nPosition);
            vTarget = GetPositionFromLocation(lLoc);
            vMyself = GetPosition(OBJECT_SELF);
            vDiff = vTarget - vMyself;
            nPiece = GetLocalInt(OBJECT_SELF, "nPiece");
            if (VectorMagnitude(vDiff) > 0.2)
            {
                ClearAllActions();
                ActionMoveToLocation(lLoc, FALSE);
            }
            if (nPiece > 0) ActionDoCommand(SetFacing(GetLocalFloat(oGM, "facing")));
            else ActionDoCommand(SetFacing(GetLocalFloat(oGM, "facing")+180.0));
            break;
    }
}
