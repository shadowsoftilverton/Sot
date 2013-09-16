//This is a generic include containing the functions used in the first room, including booms
//Written by Ave (2012/04/13)
#include "nw_i0_spells"
#include "X0_I0_SPELLS"
#include "engine"
#include "nwnx_funcs"

const int MAX_HEAPS=5;//This is the maximum number of corpse heaps
const int MAX_CRITTERTYPES=3;
const int MAX_PEDESTAL=4;

const string SLAADPRINT1="ave_d_slaad1";
const string SLAADPRINT2="ave_d_slaadi2";
const string SLAAD_ROCK_PRINT="ave_d_slaadrock";
const string SLAAD_WAYPOINT="ave_d_slaad";

//This makes the spirit choose a corpse from among all remaining corpses to go to
void SpiritChooseCorpse(object oSpirit,location lLoc);

//This spawns a spirit at lSpawnLoc
void DoSpiritSpawn(location lSpawnLoc);

//This causes a warning vfx on oOrb and then calls OrbDamage 6 seconds later
void OrbBoom(object oOrb);

//This goes with orb boom, basically it damages nearby creatures with intensity n (n must be 1-10)
void OrbDamage(object oOrb, int nIntensity);

//Makes the monster get stronger and stronger the longer it lives
void BuffLoop(object oMonster, int nIteration);

//Begins explosions and invulns on second level
void DoBeginExplodeAndInvulns(object oSkel);

//Here are the scripts

void DoBeginExplodeAndInvulns(object oSkel)
{
    object oStatue=GetObjectByTag("ave_plc_statue");
    ExecuteScript("ave_d_exploop",oStatue);
    ExecuteScript("ave_d_vulnloop",oSkel);
}

void DoSpiritSpawn(location lSpawnLoc)
{
    //location lWayPointLoc=GetLocation(GetObjectByTag("ave_way_orb"));
    object oOrb=GetObjectByTag("ave_plc_orb");
    object oSpirit=CreateObject(OBJECT_TYPE_CREATURE,"ave_spirit",lSpawnLoc,FALSE,"ave_spirit");
    if(GetIsObjectValid(oOrb)) DelayCommand(0.1,SetLocalObject(oSpirit,"ave_o_dest",oOrb));
    else DelayCommand(0.1,SetLocalObject(oSpirit,"ave_o_dest",GetObjectByTag("ave_way_orb")));

    //DelayCommand(0.1,SpiritChooseCorpse(oSpirit,lSpawnLoc));
}

void SpiritChooseCorpse(object oSpirit, location lLoc)
{
    if(GetIsObjectValid(oSpirit))
    {
        object oOrb=GetObjectByTag("ave_plc_orb");
        object oPile;
        int iHeap;
        int nSpawn;
        while(nSpawn<250&&GetIsObjectValid(oOrb))
        {//This loop is to figure out which corpse heaps are dead and which are alive
            nSpawn++;
            iHeap=Random(MAX_HEAPS)+1;
            oPile=GetObjectByTag("ave_plc_corpse"+IntToString(iHeap));
            if(GetIsObjectValid(oPile))
            {
                DelayCommand(0.1,SetLocalInt(oSpirit,"ave_myheap",iHeap));
                DelayCommand(0.1,SetLocalObject(oSpirit,"ave_o_dest",oPile));
                break;
            }
        }

        if(nSpawn>249||!GetIsObjectValid(oOrb))
        {
            location lVFX=GetLocation(oSpirit);
            //This is what the spirit says if it has nowhere to go (for example, if all corpse heaps, or the orb, has been destroyed)
            AssignCommand(oSpirit,ActionSpeakString("No! No!!! This cannot be! I have no where else to go! You will PAY!"));
            SetPlotFlag(oSpirit,FALSE);
            effect eGate=EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eGate,lVFX);
            DestroyObject(oSpirit);
            object oSuperSpirit=CreateObject(OBJECT_TYPE_CREATURE,"ave_superspirit",lLoc,FALSE,"ave_superspirit");
            DelayCommand(0.1,SetLocalInt(oSuperSpirit,"ave_orbkill",1));
        }

    }
}

void OrbBoom(object oOrb)
{
    if(GetIsObjectValid(oOrb))
    {
        effect eWarn=EffectVisualEffect(VFX_DUR_GLOW_RED);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eWarn,oOrb,6.0);
        effect eAOE=EffectVisualEffect(VFX_FNF_PWKILL);
        //DelayCommand(6.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAOE,lVFX));
        DelayCommand(6.0,OrbDamage(oOrb,10));
        DelayCommand(RoundsToSeconds(d3(2)),OrbBoom(oOrb));
    }
}

void OrbDamage(object oOrb, int nIntensity)
{
    location lLoc=GetLocation(oOrb);
    float fDir=IntToFloat(Random(360));
    effect eAOE=EffectVisualEffect(VFX_FNF_PWKILL);
    vector vVFX=GetPosition(oOrb);
    vVFX=vVFX+Vector(IntToFloat(Random(21)-10),IntToFloat(Random(21)-10),IntToFloat(Random(11)-5));
    location lVFX=Location(GetArea(oOrb),vVFX,fDir);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAOE,lVFX);
    effect eDam;
    int iDam;
    effect  eFear=EffectFrightened();
    eFear=EffectLinkEffects(eFear,EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR));
    effect  eKnock=EffectKnockdown();
    effect  eMord   = EffectVisualEffect(VFX_IMP_HEAD_ODD);
    effect  eImpact = EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);
    //float   fDur=IntToFloat(nIntensity)+12.0;
    object  oVictim=GetFirstObjectInShape(SHAPE_SPHERE,21-(IntToFloat(nIntensity)*2),lLoc);
    while(GetIsObjectValid(oVictim))
    {
        if(!GetLocalInt(oVictim,"ave_orbkill"))
        {
            //Here is where we do damage based on nIntensity
            iDam=d6(nIntensity*2);

            if(FortitudeSave(oVictim,nIntensity*2+15))
            iDam=iDam/2;

            eDam=EffectDamage(iDam,DAMAGE_TYPE_NEGATIVE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oVictim);


            if(!ReflexSave(oVictim,nIntensity*2+15))
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,SupernaturalEffect(eKnock),oVictim,6.0);


            if(!WillSave(oVictim,nIntensity*2+15))
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,SupernaturalEffect(eFear),oVictim,12.0);

            spellsDispelMagic(oVictim,(nIntensity*2)+10,eMord,eImpact,TRUE,TRUE);

            SetLocalInt(oVictim,"ave_orbkill",1);
            DelayCommand(6.0,DeleteLocalInt(oVictim,"ave_orbkill"));
        }
        oVictim=GetNextObjectInShape(SHAPE_SPHERE,21-IntToFloat(nIntensity),lLoc);
    }
    nIntensity=nIntensity-1;
    if(nIntensity>0)
    DelayCommand(IntToFloat(Random(5))*0.1,OrbDamage(oOrb,nIntensity));
}

void BuffLoop(object oMonster, int nIteration)
{
    object oOrb=GetObjectByTag("ave_plc_orb");
    if(GetIsObjectValid(oOrb))
    {
    effect eVis;
    switch(nIteration)
    {
    case 1:
    eVis=EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_YELLOW);
    break;
    case 2:
    eVis=EffectVisualEffect(VFX_DUR_AURA_YELLOW_DARK);
    break;
    case 3:
    eVis=EffectVisualEffect(VFX_DUR_AURA_YELLOW);
    break;
    case 4:
    eVis=EffectVisualEffect(VFX_DUR_AURA_YELLOW_LIGHT);
    break;
    case 5:
    eVis=EffectVisualEffect(VFX_DUR_AURA_PULSE_PURPLE_WHITE);
    break;
    case 6:
    eVis=EffectVisualEffect(VFX_DUR_AURA_PURPLE);
    break;
    case 7:
    eVis=EffectVisualEffect(VFX_DUR_AURA_PULSE_PURPLE_BLACK);
    break;
    case 8:
    eVis=EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_BLACK);
    break;
    case 9:
    eVis=EffectVisualEffect(VFX_DUR_AURA_PULSE_MAGENTA_RED);
    break;
    case 10:
    eVis=EffectVisualEffect(VFX_DUR_AURA_PULSE_GREY_BLACK);
    break;
    }
    effect eMove=EffectMovementSpeedIncrease((10*nIteration)-1);
    effect eLink=EffectLinkEffects(eMove,eVis);
    RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT,oMonster);
    RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_INCREASE,oMonster);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eLink),oMonster);
    SetLocalObject(oOrb,"ave_o_monst",oMonster);
    ExecuteScript("ave_d_visbeam",oOrb);
    nIteration++;

    int iAbility;
    while(iAbility<5)
    {
        if(iAbility!=ABILITY_CONSTITUTION)
        {
            if(GetAbilityScore(oMonster,iAbility,TRUE)<200)
            ModifyAbilityScore(oMonster,iAbility,4);
        }
        iAbility++;
    }

    if(nIteration<10)
    DelayCommand(12.0,BuffLoop(oMonster,nIteration));
    }
}

void DoSlaadEff(object oStone, int iNotHit)
{
     if(GetLocalInt(oStone,"ave_d_slaadgo")==0)
     {
         ExecuteScript("ave_d_slaadeff",oStone);//Need to fire this on stone so beam vfx look right
         DelayCommand(18.0f,DoSlaadEff(oStone,1));
         //SetLocalInt(oStone,"ave_d_slaadgo",1);
     }
}
