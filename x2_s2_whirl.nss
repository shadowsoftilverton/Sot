//::///////////////////////////////////////////////
//:: x2_s2_whirl.nss
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Performs a whirlwind or improved whirlwind
    attack.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-08-20
//:://////////////////////////////////////////////
//:: Updated By: GZ, Sept 09, 2003
#include "ave_inc_combat"
#include "ave_inc_duration"
#include "inc_modalfeats"

void main()
{
    if(WhirlwindAttackActive(OBJECT_SELF)==0) ActivateWhirlwindAttack(OBJECT_SELF);
    else RemoveWhirlwindAttackEffect(OBJECT_SELF);
}


void OldWhirlNoLongerUsed()
{
    int bImproved = (GetSpellId() == 645);// improved whirlwind
    DoGeneralOnCast(OBJECT_SELF);
    /* Play random battle cry */
    int nSwitch = d10();
    switch (nSwitch)
    {
        case 1: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
        case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
        case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
    }

    // * GZ, Sept 09, 2003 - Added dust cloud to improved whirlwind
    if (bImproved)
    {
      effect eVis = EffectVisualEffect(460);
      DelayCommand(0.5f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF));
    }

    SoT_DoWhirlwindAttack(TRUE,bImproved);
    // * make me resume combat
}

