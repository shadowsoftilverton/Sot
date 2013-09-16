void DoKobDamage(location lLoc, int nDC, int nCL, object oPC, int nMetaMagic)
{
    int nDam;
    effect eAOE=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAOE,lLoc);
    object oVictim=GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,lLoc);
    while(GetIsObjectValid(oVictim))
    {
        //SendMessageToPC(oPC,"Debug: valid target found!");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eAOE,oVictim);
        if(!GetIsReactionTypeFriendly(oVictim,oPC))
        {
            //SendMessageToPC(oPC,"Debug: this target is unfriendly!");
            if(nMetaMagic==METAMAGIC_EMPOWER) nDam=FloatToInt(d3(nCL)*1.5);
            else if(nMetaMagic==METAMAGIC_MAXIMIZE) nDam=3*nCL;
            else nDam=d3(nCL);
            nDam=GetReflexAdjustedDamage(nDam,oVictim,nDC,SAVING_THROW_TYPE_ACID,oPC);
            effect eDam=EffectDamage(nDam,DAMAGE_TYPE_ACID);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oVictim);
        }
        oVictim=GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE, lLoc);
    }
}

void main()
{
    object oPC=OBJECT_SELF;
    object oTempPlace=GetObjectByTag("ave_temp_kobdie"+IntToString(GetLocalInt(oPC,"ave_kobnum")));
    int nDC=GetLocalInt(oTempPlace,"ave_kobdc");
    int nCL=GetLocalInt(oTempPlace,"ave_koblevel");
    int nMetaMagic=GetLocalInt(oTempPlace,"ave_kobmeta");
    location lLoc=GetLocation(oTempPlace);
    //if(GetIsObjectValid(oTempPlace)) SendMessageToPC(oPC,"Debug: Placeable valid.");
    DestroyObject(oTempPlace);
    DelayCommand(0.1,DoKobDamage(lLoc,nDC,nCL,oPC,nMetaMagic));
}
