#include "engine"
#include "x2_inc_itemprop"

/*
int WeaponProficiencyLevel(object oCaster, object oWeapon)
{
    int nSim = GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oCaster);
    int nMar = GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oCaster);
    int nExo = GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oCaster);
    int nWiz = GetHasFeat(FEAT_WEAPON_PROFICIENCY_WIZARD, oCaster);
    int nRog = GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oCaster);
    int nMnk = GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK, oCaster);
    int nDru = GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oCaster);
    int nElf = GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELF, oCaster);
    int nDrf = GetHasFeat(FEAT_WEAPON_PROFICIENCY_DWARF, oCaster);

    int nWeapon = GetBaseItemType(oWeapon);
    int nProf;

    switch(nWeapon)
    {
        case BASE_ITEM_BASTARDSWORD: nProf = nMar + nExo; break;
        case BASE_ITEM_BATTLEAXE: nProf = nMar; break;
        case BASE_ITEM_CLUB: nProf = nSim + Wiz + nDru + nRog; break;
        case BASE_ITEM_DAGGER: nSim; break;
        case BASE_ITEM_DIREMACE: nProf = nMar + nExo; break;
        case BASE_ITEM_DOUBLEAXE: sWeapon = ""; break;
        case BASE_ITEM_DWARVENWARAXE: sWeapon = ""; break;
        case BASE_ITEM_GREATAXE: sWeapon = ""; break;
        case BASE_ITEM_GREATSWORD: sWeapon = ""; break;
        case BASE_ITEM_HALBERD: sWeapon = ""; break;
        case BASE_ITEM_HANDAXE: sWeapon = ""; break;
        case BASE_ITEM_HEAVYFLAIL: sWeapon = ""; break;
        case BASE_ITEM_KAMA: sWeapon = ""; break;
        case BASE_ITEM_KATANA: sWeapon = ""; break;
        case BASE_ITEM_KUKRI: sWeapon = ""; break;
        case BASE_ITEM_LIGHTFLAIL: sWeapon = ""; break;
        case BASE_ITEM_LIGHTHAMMER: sWeapon = ""; break;
        case BASE_ITEM_LIGHTMACE: sWeapon = ""; break;
        case BASE_ITEM_LONGSWORD: sWeapon = ""; break;
        case BASE_ITEM_MAGICSTAFF: sWeapon = ""; break;
        case BASE_ITEM_MORNINGSTAR: sWeapon = ""; break;
        case BASE_ITEM_QUARTERSTAFF: sWeapon = ""; break;
        case BASE_ITEM_RAPIER: sWeapon = ""; break;
        case BASE_ITEM_SCIMITAR: sWeapon = ""; break;
        case BASE_ITEM_SCYTHE: sWeapon = ""; break;
        case BASE_ITEM_SHORTSPEAR: sWeapon = ""; break;
        case BASE_ITEM_SHORTSWORD: sWeapon = ""; break;
        case BASE_ITEM_SICKLE: sWeapon = ""; break;
        case BASE_ITEM_TRIDENT: sWeapon = ""; break;
        case BASE_ITEM_TWOBLADEDSWORD: sWeapon = ""; break;
        case BASE_ITEM_WARHAMMER: sWeapon = ""; break;
        case BASE_ITEM_WHIP: sWeapon = ""; break;
    }

    return sWeapon;
}
*/

int MainAbility(object oCaster)
{
    int nWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCaster);
    int nSorcer = GetLevelByClass(CLASS_TYPE_SORCERER, oCaster);
    int nCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oCaster);
    int nAbility;

    if(nWizard >= nSorcer && nWizard >= nCleric)        nAbility = ABILITY_INTELLIGENCE;
    else if(nSorcer >= nWizard && nSorcer >= nCleric)   nAbility = ABILITY_CHARISMA;
    else if(nCleric >= nWizard && nCleric >= nSorcer)   nAbility = ABILITY_WISDOM;

    return nAbility;
}

void UnsummonBlade(object oCreature, float fDuration)
{
    //effect eUnsummon = EffectVisualEffect(VFX_FNF_PWSTUN, FALSE);
    location lSummon = GetLocation(oCreature);
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCreature);

    DestroyObject(oWeapon, fDuration);
    DestroyObject(oCreature, fDuration + 1.0f);
    //DelayCommand(fDuration, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnsummon, lSummon));
}

void ReturnBlade(string sWeapon)
{
    object oOriginal = GetObjectByTag(sWeapon);
    object oOwner = GetLocalObject(oOriginal, "BladeOwner");

    ActionGiveItem(oOriginal, oOwner);

    ActionSpeakString("sWeapon:" + sWeapon);
    ActionSpeakString("sOwner: " + GetName(oOwner));
}


