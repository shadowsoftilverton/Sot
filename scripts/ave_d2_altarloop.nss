void DecrementDice(object oVictim)
{
    int nDice=GetLocalInt(oVictim,"ave_d2_loopkill");
    if(nDice>0) SetLocalInt(oVictim,"ave_d2_loopkill",nDice-1);
}

void main()
{
    object oAltar=OBJECT_SELF;
    location lLoc=GetLocation(oAltar);
    object oVictim=GetFirstObjectInShape(SHAPE_SPHERE,10.0,lLoc,TRUE,OBJECT_TYPE_CREATURE);
    if(GetIsObjectValid(oVictim))
    {
        int nDice;
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_LOS_EVIL_30),lLoc);
        while(GetIsObjectValid(oVictim))
        {
            nDice=GetLocalInt(oVictim,"ave_d2_loopkill");
            nDice=nDice+1;
            SetLocalInt(oVictim,"ave_d2_loopkill",nDice);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d10(nDice),DAMAGE_TYPE_MAGICAL),oVictim);
            DelayCommand(1800.0,DecrementDice(oVictim));
            oVictim=GetNextObjectInShape(SHAPE_SPHERE,25.0,lLoc,FALSE,OBJECT_TYPE_CREATURE);
        }
    }
    DelayCommand(30.0,ExecuteScript("ave_d2_altarloop",oAltar));
}
