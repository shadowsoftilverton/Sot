//::///////////////////////////////////////////////////
//:: X0_S1_PETRGAZE
//:: Petrification gaze monster ability.
//:: Fortitude save (DC 15) or be turned to stone permanently.
//:: This will be changed to a temporary effect.
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/14/2002
//::///////////////////////////////////////////////////
//:: Used by Basilisk


#include "x0_i0_spells"
#include "x0_i0_position"

void main()
{
    object oTarget = GetSpellTargetObject();
    int nHitDice = GetHitDice(OBJECT_SELF);
    float fDuration = IntToFloat(nHitDice);
    location lTargetLocation = GetSpellTargetLocation();
    float fDelay;
    int nSpellID = GetSpellId();

    object oLooker = OBJECT_SELF;
    //object oLookee;
    //float fLooker = GetFacing(oLooker);
    //float fLookee;
    //float fAxis;
    //vector vLooker = GetPosition(oLooker);
    //vector vLookee;
    //vector vGhost;
    //float fGhost;
    //float fDistance;
    //float fHypot;

    //float vX;
    //float vY;
    //float vZ;

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE);

    while(GetIsObjectValid(oTarget))
    {
        //fDistance = GetDistanceBetween(oLooker, oLookee);
        //fHypot = sqrt((fDistance * fDistance) * 2);    //Hypotenuse of triangle.

        //fGhost = GetRightDirection(fLooker);   //90 degrees from where the caller is facing.
        //vGhost = AngleToVector(fGhost);
        //vX = vPosition.x - vGhost.x;
        //vY = vPosition.y - vGhost.y;
        //vZ = vPosition.z;
        //vGhost = Vector(vX, vY, vZ); //Point from where distance is calculated. If greater than the hypotenuse, the target is not facing.


        //fLookee = GetFacing(oLookee);

            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            DelayCommand(fDelay,  DoPetrification(nHitDice, oLooker, oTarget, nSpellID, 17));

        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE);
    }
}

