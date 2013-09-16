#include "engine"

#include "nw_i0_plot"

const int STORE_BIAS_MAX = 5;
const int STORE_BIAS_MIN = -10;

const string STORE_TAG = "store_tag";

const string STORE_BIAS_HUMAN    = "store_bias_human";
const string STORE_BIAS_HALFELF  = "store_bias_halfelf";
const string STORE_BIAS_ELF      = "store_bias_elf";
const string STORE_BIAS_HALFLING = "store_bias_halfling";
const string STORE_BIAS_GNOME    = "store_bias_gnome";
const string STORE_BIAS_DWARF    = "store_bias_dwarf";
const string STORE_BIAS_HALFORC  = "store_bias_halforc";

void main()
{
    object oSelf = OBJECT_SELF;

    string sTag = GetLocalString(oSelf, STORE_TAG);

    object oPC = GetPCSpeaker();
    object oStore = GetNearestObjectByTag(sTag);

    int nBias;

    switch(GetRacialType(oPC)){
        case RACIAL_TYPE_HUMAN:    nBias = GetLocalInt(oSelf, STORE_BIAS_HUMAN);    break;
        case RACIAL_TYPE_HALFELF:  nBias = GetLocalInt(oSelf, STORE_BIAS_HALFELF);  break;
        case RACIAL_TYPE_ELF:      nBias = GetLocalInt(oSelf, STORE_BIAS_ELF);      break;
        case RACIAL_TYPE_HALFLING: nBias = GetLocalInt(oSelf, STORE_BIAS_HALFLING); break;
        case RACIAL_TYPE_GNOME:    nBias = GetLocalInt(oSelf, STORE_BIAS_GNOME);    break;
        case RACIAL_TYPE_DWARF:    nBias = GetLocalInt(oSelf, STORE_BIAS_DWARF);    break;
        case RACIAL_TYPE_HALFORC:  nBias = GetLocalInt(oSelf, STORE_BIAS_HALFORC);  break;
    }

    if(nBias > STORE_BIAS_MAX) nBias = STORE_BIAS_MAX;
    if(nBias < STORE_BIAS_MIN) nBias = STORE_BIAS_MIN;

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        gplotAppraiseOpenStore(oStore, GetPCSpeaker(), nBias, nBias);
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
