#include "engine"

void main()
{
    object oSelf = OBJECT_SELF;
    string sDamageType;
    int iDamageType;
    int iSpell = GetSpellId();

    switch(iSpell){
        case 846: // FIRE
            iDamageType = DAMAGE_TYPE_FIRE;
            sDamageType = "fire";
        break;

        case 847: // COLD
            iDamageType = DAMAGE_TYPE_COLD;
            sDamageType = "cold";
        break;

        case 848: // ACID
            iDamageType = DAMAGE_TYPE_ACID;
            sDamageType = "acid";
        break;

        case 849: // ELECTRICAL
            iDamageType = DAMAGE_TYPE_ELECTRICAL;
            sDamageType = "electrical";
        break;

        case 850: // NORMAL
            iDamageType = -1;
            sDamageType = "normal";
        break;
    }

    if(iDamageType == -1){
        DeleteLocalInt(oSelf, "SPELL_ELEMENTAL_TYPE");
    } else {
        SetLocalInt(oSelf, "SPELL_ELEMENTAL_TYPE", iDamageType);
    }

    FloatingTextStringOnCreature("Your spells will now do " + sDamageType +
        " damage." , oSelf, TRUE);
}
