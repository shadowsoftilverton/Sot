#include "engine"
#include "x2_inc_itemprop"
#include "x3_inc_string"
#include "inc_ilr"
#include "inc_xp"
#include "ave_inc_tables"

const int FEAT_PA_FLETCHING=1668;

string GetLabelFromTier(int nTier);

int GetIsValidPropertyOnItem(string ItemProperty, int MyType, object oPC)
{
    //SendMessageToPC(oPC,"Checking the category of item type "+IntToString(MyType));
    string ColumnToCheck=CraftingBaseItemTo2daColumn(MyType);
    if(ItemProperty=="On_Hit_Properties")
    {
        if(ColumnToCheck!="0_Melee"&&ColumnToCheck!="1_Ranged"&&ColumnToCheck!="3_Staves"&&ColumnToCheck!="2_Thrown"&&ColumnToCheck!="5_Ammo"&&ColumnToCheck!="21_Glove")
        return 0;
    }
    //SendMessageToPC(oPC,"Item is category "+ColumnToCheck);
    int iIteration;
    //SendMessageToPC(oPC,"Searching for property "+ItemProperty);
    for(iIteration=0;iIteration<88;iIteration++)
    {
        if(ItemProperty==Get2DAString("itemprops","Label",iIteration))
        {
            //SendMessageToPC(oPC,"Found 2DA column for itemproperty in column"+IntToString(iIteration));
            string IsValid=Get2DAString("itemprops",ColumnToCheck,iIteration);
            //SendMessageToPC(oPC,"String"+IsValid+"denotes validity?");
            if(IsValid=="1")
            {
                //SendMessageToPC(oPC,"Is Valid!");
                return 1;
            }
        }
    }
    return 0;
}


int ReagRandom(int nMax, int bBypass)
{
    if(bBypass==TRUE) return nMax-1;
    return Random(nMax);
}

int TierToDamageConstant(int nTier)
{
   switch(nTier)
   {
   case 1: return IP_CONST_DAMAGEBONUS_1;
   case 2: return IP_CONST_DAMAGEBONUS_2;
   case 3: if(Random(2)==1) return IP_CONST_DAMAGEBONUS_3;
   else return IP_CONST_DAMAGEBONUS_1d4;
   case 4: if(Random(2)==1) return IP_CONST_DAMAGEBONUS_4;
   else return IP_CONST_DAMAGEBONUS_1d6;
   case 5: if(Random(4)==1) return IP_CONST_DAMAGEBONUS_5;
   else if(Random(3)==1) return IP_CONST_DAMAGEBONUS_2d4;
   else return IP_CONST_DAMAGEBONUS_1d8;
   case 6: if(Random(3)==2) return IP_CONST_DAMAGEBONUS_6;
   else return IP_CONST_DAMAGEBONUS_1d10;
   case 7: if(Random(4)==1) return IP_CONST_DAMAGEBONUS_7;
   else if(Random(3)==1) return IP_CONST_DAMAGEBONUS_2d6;
   else return IP_CONST_DAMAGEBONUS_1d12;
   case 8: return IP_CONST_DAMAGEBONUS_8;
   case 9: if(Random(2)==1) return IP_CONST_DAMAGEBONUS_9;
   else return IP_CONST_DAMAGEBONUS_2d8;
   case 10: if(Random(2)==1) return IP_CONST_DAMAGEBONUS_10;
   else return IP_CONST_DAMAGEBONUS_4d4;
   case 11: if(Random(2)==1) return IP_CONST_DAMAGEBONUS_11;
   else return IP_CONST_DAMAGEBONUS_2d10;
   case 12: if(Random(2)==1) return IP_CONST_DAMAGEBONUS_12;
   else return IP_CONST_DAMAGEBONUS_5d4;
   case 13: if(Random(2)==1) return IP_CONST_DAMAGEBONUS_13;
   else return IP_CONST_DAMAGEBONUS_2d12;
   case 14: if(Random(2)==1) return IP_CONST_DAMAGEBONUS_14;
   else return IP_CONST_DAMAGEBONUS_3d8;
   default: return 0;
   }
   return 0;
}

//Creates a reagent up to a maximum of nTier in object oChest. If bTierMax is TRUE, only creates the best possible reagent for a given level.
object CreateReagent(int nTier,object oChest,int bTierMax=FALSE,string sTypeForce="")
{
    //int ReRoll=Random(nTier+1);
    //if(ReRoll<nTier) nTier=ReRoll;//Weights more heavily toward lower quality reagents
    int nDesiredTier=nTier;//Preserves information about the desired tier for later use
    int ReagentAppearance=Random(38)+1;
    object MyReagent=CreateItemOnObject("craftreag"+IntToString(ReagentAppearance),oChest);
    DelayCommand(0.0,SetLocalInt(MyReagent,"IsCraftingReagent",1));
    string IPMainType;
    int IPVar1Type;
    int IPVar2Type;
    int AbilityBonusWeight=15;
    int ACBonusWeight=7;
    int DamageBonusWeight=8;
    int MightyWeight=3;
    int AttackBonusWeight=3;
    int VampiricWeight=4;
    int MassCritWeight=4;
    int BonusSlotWeight=15;
    int SaveWeight=10;
    int KeenWeight;
    int RegenWeight;
    int UniSaveWeight;
    int ArcaneSpellFailureWeight;
    int OnHitWeight=2;
    if(nTier>3)
    {
        KeenWeight=1;
        RegenWeight=5;
        UniSaveWeight=4;
        ArcaneSpellFailureWeight=1;
    }
    else if(nTier>2)
    {
        KeenWeight=1;
        RegenWeight=1;
        UniSaveWeight=2;
        ArcaneSpellFailureWeight=0;
    }
    else
    {
        KeenWeight=0;
        RegenWeight=0;
        UniSaveWeight=0;
        ArcaneSpellFailureWeight=0;
    }
    int iTotalWeight=ArcaneSpellFailureWeight+AbilityBonusWeight+ACBonusWeight+DamageBonusWeight+MightyWeight+AttackBonusWeight+VampiricWeight+MassCritWeight+BonusSlotWeight+KeenWeight+RegenWeight+SaveWeight+UniSaveWeight+OnHitWeight;
    int iSelect=Random(iTotalWeight);
    string ItemLabel;

    if(sTypeForce!="") iSelect=2+iTotalWeight;

    iSelect=iSelect-AbilityBonusWeight;
    if(iSelect<0|sTypeForce=="Ability_Bonus")
    {
        IPMainType="Ability_Bonus";
        IPVar1Type=Random(6);
        switch(IPVar1Type)
        {case 0: ItemLabel="Strength";
        break;
        case 1: ItemLabel="Dexterity";
        break;
        case 2: ItemLabel="Constitution";
        break;
        case 3: ItemLabel="Intelligence";
        break;
        case 4: ItemLabel="Wisdom";
        break;
        case 5: ItemLabel="Charisma";
        break;}
        IPVar2Type=ReagRandom(nTier,bTierMax)+1;
        if(IPVar2Type>4) IPVar2Type=4;
        nTier=IPVar2Type;
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-ACBonusWeight;
    if(iSelect<0|sTypeForce=="AC_Bonus")
    {
        ItemLabel="Armoring";
        IPMainType="AC_Bonus";
        IPVar1Type=ReagRandom(nTier,bTierMax)+1;
        if(IPVar1Type>3)
        {
            if(IPVar1Type==7) IPVar1Type=4;
            else IPVar1Type=3;
        }
        nTier=IPVar1Type;
        if(IPVar1Type==4) nTier=7;
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-DamageBonusWeight;
    if(iSelect<0|sTypeForce=="Damage_Bonus")
    {
        int DamageMasterType;
        if(nTier>3) DamageMasterType=Random(6);
        else if(nTier==3) DamageMasterType=Random(5);
        else if(nTier==2) DamageMasterType=Random(4);
        else DamageMasterType=1;
        IPMainType="Damage_Bonus";
        if(DamageMasterType<3)
        {
            ItemLabel="Damage";
            IPVar1Type=Random(3);//Generates blunt, pierce, slash
            nTier=ReagRandom(nTier,bTierMax)+1;
            IPVar2Type=TierToDamageConstant(nTier);
        }
        else if(DamageMasterType==5)
        {
            IPVar1Type=Random(5);//Sonic, Positive, Negative, Magic, Divine
            switch(IPVar1Type)
            {case 0: IPVar1Type=5;
            ItemLabel="Silverfire";
            break;
            case 1: IPVar1Type=8;
            ItemLabel="Godsrage";
            break;
            case 2: IPVar1Type=11;
            ItemLabel="Lifebane";
            break;
            case 3: IPVar1Type=12;
            ItemLabel="Radiant";
            break;
            case 4: IPVar1Type=13;
            ItemLabel="Screaming";
            break;}
            nTier=ReagRandom(nTier-1,bTierMax)+2;
            IPVar2Type=TierToDamageConstant(nTier-1);
        }
        else
        {
            IPVar1Type=Random(4);//Acid, Cold, Electrical, Fire
            switch(IPVar1Type)
            {case 0: IPVar1Type=6;
            ItemLabel="Acid";
            break;
            case 1: IPVar1Type=7;
            ItemLabel="Ice";
            break;
            case 2: IPVar1Type=9;
            ItemLabel="Skyfire";
            break;
            case 3: IPVar1Type=10;
            ItemLabel="Searing";
            break;}
            nTier=ReagRandom(nTier,bTierMax)+1;
            IPVar2Type=TierToDamageConstant(nTier);
        }
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-MightyWeight;
    if(iSelect<0|sTypeForce=="Mighty")
    {
        ItemLabel="Mighty";
        IPMainType="Mighty";
        IPVar1Type=ReagRandom(nTier,bTierMax)+1;
        nTier=IPVar1Type;
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-AttackBonusWeight;
    if(iSelect<0|sTypeForce=="Attack_Bonus")
    {
        ItemLabel="Attack";
        IPMainType="Attack_Bonus";
        IPVar1Type=ReagRandom(nTier,bTierMax)+1;
        nTier=IPVar1Type;
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-VampiricWeight;
    if(iSelect<0|sTypeForce=="Vampiric_Regeneration")
    {
        ItemLabel="Vampire";
        IPMainType="Vampiric_Regeneration";
        IPVar1Type=ReagRandom(nTier,bTierMax)+1;
        nTier=IPVar1Type;
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-MassCritWeight;
    if(iSelect<0|sTypeForce=="Massive_Criticals")
    {
        ItemLabel="Destruction";
        IPMainType="Massive_Criticals";
        nTier=ReagRandom(nTier,bTierMax)+1;
        IPVar1Type=TierToDamageConstant((nTier*2)-Random(2));
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-BonusSlotWeight;
    if(iSelect<0|sTypeForce=="Bonus_Spell_Slot_of_Level_n")
    {
        IPMainType="Bonus_Spell_Slot_of_Level_n";
        IPVar2Type=ReagRandom(nTier*2,bTierMax)+1;
        switch(Random(7))
        {
        case 0: IPVar1Type=IP_CONST_CLASS_BARD;
        ItemLabel="Musical";
        if(IPVar2Type>6) IPVar2Type=6;
        break;
        case 1: IPVar1Type=IP_CONST_CLASS_CLERIC;
        ItemLabel="Priestly";
        if(IPVar2Type>9) IPVar2Type=9;
        break;
        case 2: IPVar1Type=IP_CONST_CLASS_DRUID;
        ItemLabel="Nature";
        if(IPVar2Type>9) IPVar2Type=9;
        break;
        case 3: IPVar1Type=IP_CONST_CLASS_PALADIN;
        ItemLabel="Crusader's";
        if(IPVar2Type>4) IPVar2Type=4;
        break;
        case 4: IPVar1Type=IP_CONST_CLASS_RANGER;
        ItemLabel="Tracker's";
        if(IPVar2Type>4) IPVar2Type=4;
        break;
        case 5: IPVar1Type=IP_CONST_CLASS_SORCERER;
        ItemLabel="Sorcery";
        if(IPVar2Type>9) IPVar2Type=9;
        break;
        case 6: IPVar1Type=IP_CONST_CLASS_WIZARD;
        ItemLabel="Magecraft";
        if(IPVar2Type>9) IPVar2Type=9;
        break;
        }
        nTier=((IPVar2Type/2)+1);
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-KeenWeight;
    if(iSelect<0|sTypeForce=="Keen_Blade")
    {
        ItemLabel="Keen";
        IPMainType="Keen_Blade";
        nTier=3;
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-RegenWeight;
    if(iSelect<0|sTypeForce=="Regeneration")
    {
        ItemLabel="Regenerative";
        IPMainType="Regeneration";
        IPVar1Type=(ReagRandom(nTier-2,bTierMax)+2)/2;
        nTier=(IPVar1Type*2)+1;
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-SaveWeight;
    if(iSelect<0|sTypeForce=="Improved_Saving_Throws")
    {
        IPMainType="Improved_Saving_Throws";
        nTier=ReagRandom(nTier,bTierMax)+1;
        //if(nTier<3) nTier=3;
        IPVar2Type=(nTier);
        IPVar1Type=Random(3)+1;
        switch(IPVar1Type)
        {case IP_CONST_SAVEBASETYPE_FORTITUDE: ItemLabel="Resiliance"; break;
        case IP_CONST_SAVEBASETYPE_REFLEX: ItemLabel="Rogue"; break;
        case IP_CONST_SAVEBASETYPE_WILL: ItemLabel="Stoic"; break;}
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-UniSaveWeight;
    if(iSelect<0|sTypeForce=="Improved_Saving_Throws:_Specific")
    {
        IPMainType="Improved_Saving_Throws:_Specific";
        ItemLabel="Monk";
        IPVar1Type=IP_CONST_SAVEVS_UNIVERSAL;
        IPVar2Type=ReagRandom(nTier/3,bTierMax)+1;
        nTier=IPVar2Type*3;
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-OnHitWeight;
    if(iSelect<0|sTypeForce=="On_Hit_Properties")
    {
        IPMainType="On_Hit_Properties";
        if(nTier>2)//Best properties
        {
        int MedProps=Random(6);
        switch(MedProps)
            {
            case 0: IPVar1Type=IP_CONST_ONHIT_CONFUSION; ItemLabel="Addlestrike"; break;
            case 1: IPVar1Type=IP_CONST_ONHIT_DAZE; ItemLabel="Dazestrike"; break;
            case 2: IPVar1Type=IP_CONST_ONHIT_GREATERDISPEL; ItemLabel="Magic Crushing"; break;
            case 3: IPVar1Type=IP_CONST_ONHIT_HOLD; ItemLabel="Paralytic"; break;
            case 4: IPVar1Type=IP_CONST_ONHIT_STUN; ItemLabel="Stunning"; break;
            case 5: IPVar1Type=IP_CONST_ONHIT_BLINDNESS; ItemLabel="Eyebiter"; break;
            }
        IPVar2Type=ReagRandom(nTier-2,bTierMax)+1;
        if(IPVar2Type>5) IPVar2Type=5;
        nTier=IPVar2Type+2;
        }
        else if(nTier>1)//Medium Properties
        {
        int MedProps=Random(5);
        switch(MedProps)
            {
            case 0: IPVar1Type=IP_CONST_ONHIT_DISPELMAGIC; ItemLabel="Magic Piercing"; break;
            case 1: IPVar1Type=IP_CONST_ONHIT_SLOW; ItemLabel="Slowstrike"; break;
            case 2: IPVar1Type=IP_CONST_ONHIT_SILENCE; ItemLabel="Voicestealer"; break;
            case 3: IPVar1Type=IP_CONST_ONHIT_VORPAL; ItemLabel="Beheading"; break;
            case 4: IPVar1Type=IP_CONST_ONHIT_SLEEP; ItemLabel="Soporific"; break;
            }
        IPVar2Type=ReagRandom(nTier,bTierMax)+1;
        if(IPVar2Type>6) IPVar2Type=6;
        nTier=IPVar2Type;
        }
        else//Low Properties
        {
        int LowProps=Random(5);
        switch(LowProps)
            {
            case 0: IPVar1Type=IP_CONST_ONHIT_DEAFNESS; ItemLabel="Deafstrike"; break;
            case 1: IPVar1Type=IP_CONST_ONHIT_DOOM; ItemLabel="Doomstrike"; break;
            case 2: IPVar1Type=IP_CONST_ONHIT_LESSERDISPEL; ItemLabel="Magic Slicing"; break;
            case 3: IPVar1Type=IP_CONST_ONHIT_WOUNDING; ItemLabel="Bleeder"; break;
            case 4: IPVar1Type=IP_CONST_ONHIT_LEVELDRAIN; ItemLabel="Weakstrike"; break;
            }
        IPVar2Type=ReagRandom(nTier*2,bTierMax)+1;
        if(IPVar2Type>6) IPVar2Type=6;
        nTier=FloatToInt(IPVar2Type/2.0);
        if(nTier==0) nTier=1;
        }
        iSelect=iSelect+iTotalWeight;
    }

    iSelect=iSelect-ArcaneSpellFailureWeight;
    if(iSelect<0|sTypeForce=="Arcane_Spell_Failure")
    {
        IPMainType="Arcane_Spell_Failure";
        ItemLabel="Spellsword";
        nTier=ReagRandom(nTier,bTierMax);
        if(nTier>5)
        {
            nTier=6;
            IPVar1Type=IP_CONST_ARCANE_SPELL_FAILURE_MINUS_10_PERCENT;
        }
        else
        {
            nTier=4;
            IPVar1Type=IP_CONST_ARCANE_SPELL_FAILURE_MINUS_5_PERCENT;
        }
        iSelect=iSelect+iTotalWeight;
    }
    if(bTierMax==1&nTier!=nDesiredTier)
    {
        DestroyObject(MyReagent);
        return OBJECT_INVALID;
    }
    DelayCommand(0.0,SetLocalString(MyReagent,"IPMain",IPMainType));
    DelayCommand(0.0,SetLocalInt(MyReagent,"IPVar1",IPVar1Type));
    DelayCommand(0.0,SetLocalInt(MyReagent,"IPVar2",IPVar2Type));
    DelayCommand(0.0,SetLocalInt(MyReagent,"IPVarTier",nTier));
    string sName=(GetLabelFromTier(nTier)+" "+ItemLabel+" Reagent");
    sName=StringToRGBString(sName,TierToColor(nTier));
    DelayCommand(0.0,SetName(MyReagent, sName));
    return MyReagent;
}

int GetHasMatchingProps(object oItem, itemproperty ipCheck)//Checks to see if item oItem already has itemproperty ipCheck
{
    itemproperty ipLoop=GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipLoop))
    {
        if(GetItemPropertyType(ipLoop)==GetItemPropertyType(ipCheck))
        {
            if(GetItemPropertyType(ipLoop)==ITEM_PROPERTY_ABILITY_BONUS)
            {
                if(GetItemPropertySubType(ipLoop)==GetItemPropertySubType(ipCheck)) return 1;
                else return 0;
            }
            return 1;
        }
        ipLoop=GetNextItemProperty(oItem);
    }
    return 0;
}

int GetRequiredGoldByTier(int nTier)
{
    switch(nTier)
    {
    case 1: return 1;
    case 2: return 10;
    case 3: return 100;
    case 4: return 1000;
    case 5: return 10000;
    case 6: return 30000;
    case 7: return 60000;
    }
    return -1;
}

int GetCraftingSuccessFailure(object oPC, object oItem, int nPropertyTier, int IsForReal)
{
    itemproperty ipLoop=GetFirstItemProperty(oItem);
    int nPropertyCount=0;
    int iChance=0;
    int iFeatReq=0;
    int iMyBaseType=GetBaseItemType(oItem);
    int iSkillMod;
    switch(iMyBaseType)
    {
         case BASE_ITEM_AMULET: iFeatReq=1;
         break;
         case BASE_ITEM_RING: iFeatReq=1;
         break;
         case BASE_ITEM_MAGICSTAFF: iFeatReq=2;
         break;
         case BASE_ITEM_HELMET: iFeatReq=3;
         break;
         case BASE_ITEM_GLOVES: iFeatReq=4;
         break;
         default: string FindType=CraftingBaseItemTo2daColumn(iMyBaseType);
         if(FindType=="0_Melee"){iFeatReq=4;
         break;}
         if(FindType=="2_Thrown"){iFeatReq=4;
         break;}
         if(FindType=="1_Ranged"){iFeatReq=4;
         break;}
         if(FindType=="5_Ammo"){iFeatReq=4;
         break;}
         if(FindType=="6_Arm_Shld"){iFeatReq=3;
         break;}
         if(FindType=="16_Misc"){iFeatReq=5;
         break;}
         iFeatReq=2;
    }
    int nBonusSlot=0;
    while(GetIsItemPropertyValid(ipLoop))
    {
        if(!(GetItemPropertyType(ipLoop)==ITEM_PROPERTY_ATTACK_BONUS))
        {
            if(GetItemPropertyType(ipLoop)==ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
            {
                if(nBonusSlot>1)
                {
                   nPropertyCount++;
                }
                nBonusSlot++;
            }
            else {nPropertyCount++;}
        }
        ipLoop=GetNextItemProperty(oItem);
    }
    if(nPropertyCount==0)
    {
        iChance=95;
    }
    else if(nPropertyCount==1)
    {
        iChance=65;
    }
    else if(nPropertyCount==2)
    {
        iChance=35;
    }
    else if(nPropertyCount==3)
    {
        iChance=5;
    }
    else if(nPropertyCount==4)
    {
        iChance=-65;
    }
    else iChance=-500;
    int iBaseChance=iChance;
    if(nPropertyTier<GetLocalInt(oItem, "sys_ilr_tier"))
    nPropertyTier=GetLocalInt(oItem,"sys_ilr_tier");
    iChance=iChance-(nPropertyTier*20);
    int iTierMod=nPropertyTier*-20;
    int iFeatMod=0;
    int iPotentialXP=((100-iChance)-(GetHitDice(oPC)*5))*5;
    int nPABonus;//Peerless archer
    switch(iFeatReq)
    {
    case 1://Jewelry
    iSkillMod=2*GetSkillRank(47,oPC,FALSE);
    if(iSkillMod>160) iSkillMod=160;
    iChance=iChance+iSkillMod;
    if(GetHasFeat(1381,oPC)) iFeatMod=30;
    iChance=iChance+iFeatMod;
    if(IsForReal==0) SendMessageToPC(oPC,"This type of crafting uses the craft wondrous item feat and the craft jewelry skill...");
    break;
    case 2: //Staves
    if(GetHasFeat(946,oPC)) iFeatMod=100;
    iChance=iChance+iFeatMod;
    if(IsForReal==0) SendMessageToPC(oPC,"This type of crafting uses the craft wand feat...");
    break;
    case 3: //Armor/Shield/Helm
    iSkillMod=2*GetSkillRank(SKILL_CRAFT_ARMOR,oPC,FALSE);
    if(iSkillMod>160) iSkillMod=160;
    iChance=iChance+iSkillMod;
    if(GetHasFeat(1380,oPC)) iFeatMod=30;
    iChance=iChance+iFeatMod;
    if(IsForReal==0) SendMessageToPC(oPC,"This type of crafting uses the craft magical arms and armor feat and the craft armor skill...");
    break;
    case 4: //Weapon/ammo
    iSkillMod=2*GetSkillRank(SKILL_CRAFT_WEAPON,oPC,FALSE);
    if(iSkillMod>160) iSkillMod=160;
    iChance=iChance+iSkillMod;
    if(GetHasFeat(1380,oPC)) iFeatMod=30;
    nPABonus=GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC)*3*GetHasFeat(FEAT_PA_FLETCHING);
    if(nPABonus>iFeatMod) iFeatMod=nPABonus;
    iChance=iChance+iFeatMod;
    if(IsForReal==0) SendMessageToPC(oPC,"This type of crafting uses the craft magical arms and armor feat and the craft weapon skill...");
    break;
    case 5: //Accessory
    iSkillMod=2*GetSkillRank(46,oPC,FALSE);
    if(iSkillMod>160) iSkillMod=160;
    iChance=iChance+iSkillMod;
    if(GetHasFeat(1381,oPC)) iFeatMod=30;
    iChance=iChance+iFeatMod;
    if(IsForReal==0) SendMessageToPC(oPC,"This type of crafting uses the craft wondrous item feat and the craft accessory skill...");
    break;
    }

    if(IsForReal==0)
    {
        //if(iChance>75) SendMessageToPC(oPC,"This crafting job is easy for you.");
        //else if(iChance>50) SendMessageToPC(oPC,"This crafting job is medium for you.");
        //else if(iChance>25) SendMessageToPC(oPC,"This crafting job is hard for you.");
        //else if(iChance>0) SendMessageToPC(oPC,"This crafting job is very hard for you.");
        SendMessageToPC(oPC,"Base crafting chance for an item with these properties is "+IntToString(iBaseChance)+
        "% with a modifier of "+IntToString(iTierMod)+"% for item tier. You gain a +"+IntToString(iSkillMod)+
        "% bonus for skills and a +"+IntToString(iFeatMod)+"% bonus for feats, leading to a final success chance of "+
        IntToString(iChance)+"%.");
        if(iChance<0) {SendMessageToPC(oPC,"This crafting job is impossible for you.");
        return 2;}
    }

    if(Random(100)+1<iChance)
    {
        if(IsForReal==1)
        {
            if(iPotentialXP>0)
            {GiveAdjustedXP(oPC,Random(iPotentialXP)+1);
            SendMessageToPC(oPC,"You gain experience for successful crafting");}
        }
        return 1;
    }
    return 0;
}

string GetLabelFromTier(int nTier)
{
    switch(nTier)
    {case 1: return "Least";
    case 2: return "Lesser";
    case 3: return "Standard";
    case 4: return "Greater";
    case 5: return "Master";
    case 6: return "Grandmaster";
    case 7: return "Supreme";}
    return "";
}

void DoCraft(object oPC, object oChest, int IsForReal)
{
   if(IsForReal==0) SendMessageToPC(oPC,"Crafting Initialized...");
   object oItem;
   object oGoldCheck=GetFirstItemInInventory(oChest);
   object oGold;
   object oReagentUsed;
   itemproperty MyProperty;
   string This_Property;
   int nTier;
   if (!GetIsObjectValid(oGoldCheck))
   {
      SendMessageToPC(oPC,"No items found! You must place an item and a crafting reagent in the chest to begin crafting.");
   }
   else
   {
      //SendMessageToPC(oPC,"Valid items found, entering crafting...");
      while(GetIsObjectValid(oGoldCheck))
      {
        //SendMessageToPC(oPC,"Searching for gold...");
        if (GetResRef(oGoldCheck)=="nw_it_gold001")
        {
            //SendMessageToPC(oPC,"Gold Found!");
            oGold=oGoldCheck;
        }
        oGoldCheck=GetNextItemInInventory(oChest);
      }
      oItem=GetFirstItemInInventory(oChest);
      while(GetIsObjectValid(oItem))//Loop to look for crafting reagents
      {
        //SendMessageToPC(oPC,"Searching for crafting reagents...");
        if (GetLocalInt(oItem,"IsCraftingReagent")==1)
        {
            oReagentUsed=oItem;
            //SendMessageToPC(oPC,"This item is a crafting reagent!");
            int Var1=(GetLocalInt(oItem,"IPVar1"));
            int Var2=(GetLocalInt(oItem,"IPVar2"));
            This_Property=GetLocalString(oItem,"IPMain");
            nTier=(GetLocalInt(oItem,"IPVarTier"));
            if (GetLocalString(oItem,"IPMain")=="Ability_Bonus")
            {
                //SendMessageToPC(oPC,"This item is an ability boost crafting reagent!");
                MyProperty=ItemPropertyAbilityBonus(Var1,Var2);
            }
            if (GetLocalString(oItem,"IPMain")=="AC_Bonus")
            {
                //SendMessageToPC(oPC,"This item is an AC boost crafting reagent!");
                MyProperty=ItemPropertyACBonus(Var1);
            }
            if (GetLocalString(oItem,"IPMain")=="Damage_Bonus")
            {
                //SendMessageToPC(oPC,"This item is a damage boost crafting reagent!");
                MyProperty=ItemPropertyDamageBonus(Var1,Var2);
            }
            if (GetLocalString(oItem,"IPMain")=="Keen_Blade")
            {
                //SendMessageToPC(oPC,"This item is a keening crafting reagent!");
                MyProperty=ItemPropertyKeen();
            }
            if (GetLocalString(oItem,"IPMain")=="Mighty")
            {
                //SendMessageToPC(oPC,"This item is a mighty crafting reagent!");
                MyProperty=ItemPropertyMaxRangeStrengthMod(Var1);
            }
            if (GetLocalString(oItem,"IPMain")=="Regeneration")
            {
                //SendMessageToPC(oPC,"This item is a regeneration crafting reagent!");
                MyProperty=ItemPropertyRegeneration(Var1);
            }
            if (GetLocalString(oItem,"IPMain")=="Attack_Bonus")
            {
                //SendMessageToPC(oPC,"This item is an attack boost crafting reagent!");
                MyProperty=ItemPropertyAttackBonus(Var1);
            }
            if (GetLocalString(oItem,"IPMain")=="Vampiric_Regeneration")
            {
                //SendMessageToPC(oPC,"This item is a vampiric regen crafting reagent!");
                MyProperty=ItemPropertyVampiricRegeneration(Var1);
            }
            if (GetLocalString(oItem,"IPMain")=="Massive_Criticals")
            {
                //SendMessageToPC(oPC,"This item is a massive criticals crafting reagent!");
                MyProperty=ItemPropertyMassiveCritical(Var1);
            }
            if (GetLocalString(oItem,"IPMain")=="Improved_Saving_Throws")
            {
                //SendMessageToPC(oPC,"This item is a Saving Throws crafting reagent!");
                MyProperty=ItemPropertyBonusSavingThrow(Var1,Var2);
            }
            if (GetLocalString(oItem,"IPMain")=="Bonus_Spell_Slot_of_Level_n")
            {
                //SendMessageToPC(oPC,"This item is a Bonus Spellslot crafting reagent!");
                MyProperty=ItemPropertyBonusLevelSpell(Var1,Var2);
            }
            if(GetLocalString(oItem,"IPMain")=="Improved_Saving_Throws:_Specific")
            {
                MyProperty=ItemPropertyBonusSavingThrowVsX(Var1,Var2);
            }
            if(GetLocalString(oItem,"IPMain")=="On_Hit_Properties")
            {
                MyProperty=ItemPropertyOnHitProps(Var1,Var2);
            }
            if(GetLocalString(oItem,"IPMain")=="Arcane_Spell_Failure")
            {
                MyProperty=ItemPropertyArcaneSpellFailure(Var1);
            }
        }
        oItem=GetNextItemInInventory(oChest);
      }
      if(GetIsItemPropertyValid(MyProperty))
      {
        //SendMessageToPC(oPC,"Item property is valid!");
        object oItem2 = GetFirstItemInInventory(oChest);//Start over, looking for items to craft on
        while(GetIsObjectValid(oItem2))
        {
            //SendMessageToPC(oPC,"Searching for items that are not crafting reagents...");
            if(!(GetLocalInt(oItem2,"IsCraftingReagent")==1)) if(!(GetResRef(oItem2)=="nw_it_gold001"))
            {
               //SendMessageToPC(oPC,"Item that is not a crafting reagent found!");
               if(GetIsValidPropertyOnItem(This_Property,GetBaseItemType(oItem2),oPC))
               {
                 //SendMessageToPC(oPC,"Crafting reagent property compatible with base item type");
                 if(!GetHasMatchingProps(oItem2,MyProperty))
                    {//SendMessageToPC(oPC,"No similar property detected! Checking for gold!");
                        int nGold=GetItemStackSize(oGold);
                        int iMyCost=GetRequiredGoldByTier(nTier);
                        if(iMyCost<0)
                        {
                            SendMessageToPC(oPC,"Invalid tier of crafting reagent!");
                            return;
                        }
                        string DAColumn=CraftingBaseItemTo2daColumn(GetBaseItemType(oItem2));
                        if(DAColumn=="2_Thrown"||DAColumn=="5_Ammo") {iMyCost=iMyCost/100;}
                        if(iMyCost>nGold)
                        {
                            SendMessageToPC(oPC,"Not enough gold! You must place at least "+IntToString(iMyCost)+" gp in the chest for this property!");
                        }
                        else
                        {
                            //SendMessageToPC(oPC,"Sufficient Gold Found! Removing the required amount...");
                            int MySuccessFailure=GetCraftingSuccessFailure(oPC,oItem2,nTier,IsForReal);
                            if(IsForReal==1)
                            {
                                if(MySuccessFailure==1)
                                {
                                    SendMessageToPC(oPC,"Crafting Success! Item Property Added!");
                                    AddItemProperty(DURATION_TYPE_PERMANENT,MyProperty,oItem2);
                                    DoAddILRtoItem(oItem2,nTier);
                                    if (GetLocalString(oReagentUsed,"IPMain")=="Bonus_Spell_Slot_of_Level_n")
                                    {
                                        AddItemProperty(DURATION_TYPE_PERMANENT,MyProperty,oItem2);
                                        AddItemProperty(DURATION_TYPE_PERMANENT,MyProperty,oItem2);
                                    }
                                }
                                else
                                {
                                    SendMessageToPC(oPC,"Crafting Failure. Gold and reagent lost.");
                                    //DestroyObject(oItem2);
                                }
                                if(nGold==iMyCost) {DestroyObject(oGold,0.0);}
                                else {SetItemStackSize(oGold,nGold-iMyCost);}
                                DestroyObject(oReagentUsed,0.0);
                            }
                            else
                            {
                                AssignCommand(oChest,ActionStartConversation(oPC,"craftcon"));
                            }
                        }
                    }
                    else
                    {
                        SendMessageToPC(oPC,"This item already has a similar item property!");
                    }
                 break;
               }
               else
               {
                 SendMessageToPC(oPC,"Crafting reagent property incompatible with base item type");
               }
            }
            oItem2=GetNextItemInInventory(oChest);
        }
      }
   }
}
