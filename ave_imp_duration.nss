//Impact script for active duration spells
#include "ave_inc_duration"
#include "nwnx_structs"

void main()
{
    object oCaster = OBJECT_SELF;
    int nMetaMagic=GetLocalInt(oCaster,"ave_metamagic");
    int iActiveSpell=GetLocalInt(oCaster,"ave_duration");
    DoGeneralOnCast(oCaster);
    if(TestASF(oCaster)==1) return;
    if(iActiveSpell==SPELL_PSHOCK)
    pshock_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_RESOL)
    resol_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_MANT)
    mant_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_ECHO)
    echo_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_FWAVE)
    fwave_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_ACCE)
    acce_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_MADGOD)
    madgod_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_BURN)
    burn_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_TRUEC)
    truec_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_DBOLT)
    dbolt_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_LITAN)
    litan_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_CONFP)
    confp_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_INSPIRE)
    inspire_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_NEEDLE)
    needle_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_ACTIVE_SHIELD)
    shield_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_ARMORY)
    armory_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_GRIP)
    grip_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_KOBOLD)
    kobold_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_BREAK)
    break_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_EYESTORM)
    eyestorm_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_AIRFLAME)
    airflame_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_FLASH)
    flash_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_DESIRE)
    desire_redouble(nMetaMagic);
    if(iActiveSpell==SPELL_SUCCUBUS)
    succubus_redouble(nMetaMagic);
    if(iActiveSpell==996||iActiveSpell==995||iActiveSpell==994||iActiveSpell==993||iActiveSpell==992)
    cure_redouble(nMetaMagic,iActiveSpell);
    if(iActiveSpell==990||iActiveSpell==989||iActiveSpell==988||iActiveSpell==987||iActiveSpell==986)
    inflict_redouble(nMetaMagic,iActiveSpell);
    if(iActiveSpell==HIER_REACH_MASSHEAL)
    massheal_redouble(nMetaMagic);
    if(iActiveSpell==HIER_REACH_HEAL)
    heal_redouble(nMetaMagic);
    if(iActiveSpell==HIER_REACH_MASSHARM)
    massharm_redouble(nMetaMagic);
    if(iActiveSpell==HIER_REACH_HARM)
    harm_redouble(nMetaMagic);
    return;
}
