int GetIsOpposedAlignment(object oTarget,object oCaster)
{
    if(GetAlignmentGoodEvil(oTarget)==GetAlignmentGoodEvil(oCaster)) return 0;
    if(GetAlignmentLawChaos(oTarget)==GetAlignmentLawChaos(oCaster)) return 0;
    else return 1;
}
