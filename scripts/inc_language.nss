#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: INC_LANGUAGE.NSS                                                       :://
//:: Silver Marches Script                                                  :://
//::////////////////////////////////////////////////////////////////////////:://
/*
    Language include. Handles actual assignment of language and peripherals.
    Cyphers are in inc_cypher.nss.
*/
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By: Ashton Shapcott                                            :://
//:: Created On: Nov. 30, 2010                                              :://
//::////////////////////////////////////////////////////////////////////////:://

#include "aps_include"
#include "inc_cypher"
#include "inc_save"

//::////////////////////////////////////////////////////////////////////////:://
//:: CONSTANTS                                                              :://
//::////////////////////////////////////////////////////////////////////////:://

const int LANGUAGE_INVALID      = -1;
const int LANGUAGE_COMMON       = 0;
const int LANGUAGE_UNDERCOMMON  = 1;
const int LANGUAGE_AQUAN        = 2;
const int LANGUAGE_AURAN        = 3;
const int LANGUAGE_GIANT        = 4;
const int LANGUAGE_GNOLL        = 5;
const int LANGUAGE_IGNAN        = 6;
const int LANGUAGE_SYLVAN       = 7;
const int LANGUAGE_TERRAN       = 8;
const int LANGUAGE_TREANT       = 9;
const int LANGUAGE_ALGARONDAN   = 10;
const int LANGUAGE_ALZHEDO      = 11;
const int LANGUAGE_CHESSENTAN   = 12;
const int LANGUAGE_CHONDATHAN   = 13;
const int LANGUAGE_CHULTAN      = 14;
const int LANGUAGE_DAMARAN      = 15;
const int LANGUAGE_DAMBRATHAN   = 16;
const int LANGUAGE_DURPARI      = 17;
const int LANGUAGE_HALARDRIM    = 18;
const int LANGUAGE_HALRUAAN     = 19;
const int LANGUAGE_ILLUSKAN     = 20;
const int LANGUAGE_IMASKAR      = 21;
const int LANGUAGE_LANTANESE    = 22;
const int LANGUAGE_MIDANI       = 23;
const int LANGUAGE_MULHORANDI   = 24;
const int LANGUAGE_NEXALAN      = 25;
const int LANGUAGE_OILLUSK      = 26;
const int LANGUAGE_RASHEMI      = 27;
const int LANGUAGE_RAUMVIRA     = 28;
const int LANGUAGE_SERUSAN      = 29;
const int LANGUAGE_SHAARAN      = 30;
const int LANGUAGE_SHOU         = 31;
const int LANGUAGE_TALFIRIC     = 32;
const int LANGUAGE_TASHALAN     = 33;
const int LANGUAGE_TUIGAN       = 34;
const int LANGUAGE_TURMIC       = 35;
const int LANGUAGE_ULUIK        = 36;
const int LANGUAGE_UNTHERIC     = 37;
const int LANGUAGE_VAASAN       = 38;
const int LANGUAGE_DRUIDIC      = 39;
const int LANGUAGE_ASSASSIN     = 40;
const int LANGUAGE_TROLL        = 41;
const int LANGUAGE_THRIKREEN    = 42;
const int LANGUAGE_GRIMLOCK     = 43;
const int LANGUAGE_KUOTOAN      = 44;
const int LANGUAGE_MINOTAUR     = 45;
const int LANGUAGE_RAKSHASA     = 46;
const int LANGUAGE_STINGER      = 47;
const int LANGUAGE_LIZARDMAN    = 48;
const int LANGUAGE_ILLITHID     = 49;
const int LANGUAGE_HOBGOBLIN    = 50;
const int LANGUAGE_DUERGAR      = 51;
const int LANGUAGE_BUGBEAR      = 52;
const int LANGUAGE_GITHZERAI    = 53;
const int LANGUAGE_KORRED       = 54;
const int LANGUAGE_SAHAGUIN     = 55;
const int LANGUAGE_YUANTI       = 56;
const int LANGUAGE_PIXIE        = 57;
const int LANGUAGE_HENGEYOKAI   = 58;
const int LANGUAGE_SVIRFNEBLIN  = 59;
const int LANGUAGE_HIGH_SHOU    = 60;
const int LANGUAGE_AVERIAL      = 61;
const int LANGUAGE_KOBOLD       = 62;
const int LANGUAGE_OGRE         = 63;
const int LANGUAGE_DROW         = 64;
const int LANGUAGE_INFERNAL     = 65;
const int LANGUAGE_ABYSSAL      = 66;
const int LANGUAGE_CELESTIAL    = 67;
const int LANGUAGE_GOBLIN       = 68;
const int LANGUAGE_DRACONIC     = 69;
const int LANGUAGE_DWARVEN      = 70;
const int LANGUAGE_ELVEN        = 71;
const int LANGUAGE_GNOMISH      = 72;
const int LANGUAGE_HALFLING     = 73;
const int LANGUAGE_ORCISH       = 74;
const int LANGUAGE_CANT         = 75;
const int LANGUAGE_DROW_SIGN    = 76;

//::////////////////////////////////////////////////////////////////////////:://
//:: DECLARATION                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

// Sets the number of free general languages oPC has.
void SetFreeGeneralLanguages(object oPC, int nAmount);

// Gets the number of free general languages oPC has.
int GetFreeGeneralLanguages(object oPC);

// Modifies the number of free general languages oPC has.
void ModifyFreeGeneralLanguages(object oPC, int nAmount);

// Sets the number of free regional languages oPC has.
void SetFreeRegionalLanguages(object oPC, int nAmount);

// Gets the number of free regional languages oPC has.
int GetFreeRegionalLanguages(object oPC);

// Modifies the number of free regional languages oPC has.
void ModifyFreeRegionalLanguages(object oPC, int nAmount);

// Allows oPC to speak and understand oLanguage.
void LearnLanguage(object oPC, int nLanguage);

// Causes oPC to forget oLanguage.
void ForgetLanguage(object oPC, int nLanguage);

// Checks if oPC knows nLanguage.
int GetIsLanguageKnown(object oPC, int nLanguage);

// Applies the appropriate cypher to sMsg whilst broadcasting .
void ProcessLanguageChat(object oPC, string sMsg, int nVolume, int nLanguage = LANGUAGE_INVALID);

// Sets oPC's active language to nLanguage (LANGUAGE_*).
void SetActiveLanguage(object oPC, int nLanguage);

// Gets oPC's active language (LANGUAGE_*).
int GetActiveLanguage(object oPC);

// Deletes oPC's active language.
void DeleteActiveLanguage(object oPC);

// Returns the name of nLanguage.
string GetLanguageName(int nLanguage);

// Returns the feat corresponding to nLanguage.
int GetLanguageFeat(int nFeat);

// Returns TRUE if nLanguage is a regional language.
int GetIsRegionalLanguage(int nLanguage);

// Returns TRUE if oPC has a class to enable Speak Languages.
int GetHasSpeakLanguages(object oPC);

//::////////////////////////////////////////////////////////////////////////:://
//:: IMPLEMENTATION                                                         :://
//::////////////////////////////////////////////////////////////////////////:://

// Sets the number of free general languages oPC has.
void SetFreeGeneralLanguages(object oPC, int nAmount){
    if(nAmount == 0) DeletePersistentVariable(oPC, "LANGUAGE_FREE_GENERAL");
    else SetPersistentInt(oPC, "LANGUAGE_FREE_GENERAL", nAmount);
}

int GetFreeGeneralLanguages(object oPC){
    return GetPersistentInt(oPC, "LANGUAGE_FREE_GENERAL");
}

void ModifyFreeGeneralLanguages(object oPC, int nAmount){
    int nNew = GetFreeGeneralLanguages(oPC) + nAmount;
    SetFreeGeneralLanguages(oPC, nNew);
}

void SetFreeRegionalLanguages(object oPC, int nAmount){
    if(nAmount == 0) DeletePersistentVariable(oPC, "LANGUAGE_FREE_REGIONAL");
    else SetPersistentInt(oPC, "LANGUAGE_FREE_REGIONAL", nAmount);
}

int GetFreeRegionalLanguages(object oPC){
    return GetPersistentInt(oPC, "LANGUAGE_FREE_REGIONAL");
}

void ModifyFreeRegionalLanguages(object oPC, int nAmount){
    int nNew = GetFreeRegionalLanguages(oPC) + nAmount;
    SetFreeRegionalLanguages(oPC, nNew);
}

void LearnLanguage(object oPC, int nLanguage){
    string sName = GetLanguageName(nLanguage);

    int nLevel = GetHitDice(oPC);
    int nFeat = GetLanguageFeat(nLanguage);

    if(nFeat == -1) return;

    // FREE REGIONAL
   if(GetIsRegionalLanguage(nLanguage) && GetFreeRegionalLanguages(oPC) > 0){
        ModifyFreeRegionalLanguages(oPC, -1);
        AddKnownFeat(oPC, nFeat);
        SendMessageToPC(oPC, "You have learned " + sName + " as a free regional language.");
    } else
    // FREE GENERAL
    if(GetFreeGeneralLanguages(oPC) > 0){
        ModifyFreeGeneralLanguages(oPC, -1);
        AddKnownFeat(oPC, nFeat);
        SendMessageToPC(oPC, "You have learned " + sName + " as a free general language.");
    } else
    // SKILL POINTS
    if(GetPCSkillPoints(oPC) > 1 || GetHasSpeakLanguages(oPC) && GetPCSkillPoints(oPC) > 0){
        int nCost;

        if(GetHasSpeakLanguages(oPC)) nCost = 1;
        else                          nCost = 2;

        ModifyPCSkillPoints(oPC, -nCost);
        AddKnownFeat(oPC, nFeat);
        SendMessageToPC(oPC, "You have learned " + sName + " using " + IntToString(nCost) + " skill point(s).");
    } else {
    // FAILURE
        SendMessageToPC(oPC, "You do not have enough skill points to learn a language.");
    }

    SaveCharacter(oPC);
}

void ForgetLanguage(object oPC, int nLanguage){
    string sName = GetLanguageName(nLanguage);

    int nFeat = GetLanguageFeat(nLanguage);

    if(nFeat == -1) return;

    RemoveKnownFeat(oPC, nFeat);

    SendMessageToPC(oPC, "You no longer know the language " + sName + ".");
}

int GetIsLanguageKnown(object oPC, int nLanguage){
    int nFeat = GetLanguageFeat(nLanguage);

    if(GetIsDM(oPC)) return TRUE;
    if(nFeat == -1)  return FALSE;

    return GetHasFeat(nFeat, oPC);
}

void ProcessLanguageChat(object oPC, string sMsg, int nVolume, int nLanguage = LANGUAGE_INVALID){
    if(nLanguage == LANGUAGE_INVALID) nLanguage = GetActiveLanguage(oPC);

    // If we're speaking common, no reason to do anything.
    if(nLanguage == LANGUAGE_COMMON){
        SetPCChatMessage(sMsg);

        return;
    }
    // Error catching.
    else if(nLanguage == LANGUAGE_INVALID){
        FloatingTextStringOnCreature("Invalid Language!", oPC, FALSE);
        SetPCChatMessage("");
        return;
    }

    // Otherwise we go to work.
    switch(nLanguage){
        case LANGUAGE_ABYSSAL:      SetPCChatMessage(ProcessAbyssal(sMsg)); break;
        case LANGUAGE_ALGARONDAN:   SetPCChatMessage(ProcessAlgarondan(sMsg)); break;
        case LANGUAGE_ALZHEDO:      SetPCChatMessage(ProcessAlzhedo(sMsg)); break;
        case LANGUAGE_AQUAN:        SetPCChatMessage(ProcessAquan(sMsg)); break;
//        case LANGUAGE_ASSASSIN:     SetPCChatMessage(ProcessAssassin(sMsg)); break;             NEEDS TO BE READDED.
        case LANGUAGE_AURAN:        SetPCChatMessage(ProcessAuran(sMsg)); break;
        case LANGUAGE_AVERIAL:      SetPCChatMessage(ProcessAverial(sMsg)); break;
        case LANGUAGE_BUGBEAR:      SetPCChatMessage(ProcessBugBear(sMsg)); break;
//        case LANGUAGE_CANT:         SetPCChatMessage(ProcessCant(sMsg)); break;                 NEEDS TO BE READDED.
        case LANGUAGE_CELESTIAL:    SetPCChatMessage(ProcessCelestial(sMsg)); break;
        case LANGUAGE_CHESSENTAN:   SetPCChatMessage(ProcessChessentan(sMsg)); break;
        case LANGUAGE_CHONDATHAN:   SetPCChatMessage(ProcessChondathan(sMsg)); break;
        case LANGUAGE_CHULTAN:      SetPCChatMessage(ProcessChultan(sMsg)); break;
        case LANGUAGE_DAMARAN:      SetPCChatMessage(ProcessDamaran(sMsg)); break;
        case LANGUAGE_DAMBRATHAN:   SetPCChatMessage(ProcessDambrathan(sMsg)); break;
        case LANGUAGE_DRACONIC:     SetPCChatMessage(ProcessDraconic(sMsg)); break;
        case LANGUAGE_DROW:         SetPCChatMessage(ProcessDrow(sMsg)); break;
//        case LANGUAGE_DROW_SIGN:    SetPCChatMessage(ProcessDrowSign(sMsg)); break;             NEEDS TO BE READDED.
        case LANGUAGE_DRUIDIC:      SetPCChatMessage(ProcessDruidic(sMsg)); break;
        case LANGUAGE_DUERGAR:      SetPCChatMessage(ProcessDuergar(sMsg)); break;
        case LANGUAGE_DURPARI:      SetPCChatMessage(ProcessDurpari(sMsg)); break;
        case LANGUAGE_DWARVEN:      SetPCChatMessage(ProcessDwarf(sMsg)); break;
        case LANGUAGE_ELVEN:        SetPCChatMessage(ProcessElven(sMsg)); break;
        case LANGUAGE_GIANT:        SetPCChatMessage(ProcessGiant(sMsg)); break;
        case LANGUAGE_GITHZERAI:    SetPCChatMessage(ProcessGithzerai(sMsg)); break;
        case LANGUAGE_GNOLL:        SetPCChatMessage(ProcessGnoll(sMsg)); break;
        case LANGUAGE_GNOMISH:      SetPCChatMessage(ProcessGnome(sMsg)); break;
        case LANGUAGE_GOBLIN:       SetPCChatMessage(ProcessGoblin(sMsg)); break;
        case LANGUAGE_GRIMLOCK:     SetPCChatMessage(ProcessGrimlock(sMsg)); break;
        case LANGUAGE_HALARDRIM:    SetPCChatMessage(ProcessHalardrim(sMsg)); break;
        case LANGUAGE_HALFLING:     SetPCChatMessage(ProcessHalfling(sMsg)); break;
        case LANGUAGE_HALRUAAN:     SetPCChatMessage(ProcessHalruaan(sMsg)); break;
        case LANGUAGE_HENGEYOKAI:   SetPCChatMessage(ProcessHengeyokai(sMsg)); break;
        case LANGUAGE_HIGH_SHOU:    SetPCChatMessage(ProcessHighShou(sMsg)); break;
        case LANGUAGE_HOBGOBLIN:    SetPCChatMessage(ProcessHobgoblin(sMsg)); break;
        case LANGUAGE_ILLITHID:     SetPCChatMessage(ProcessIllithid(sMsg)); break;
        case LANGUAGE_ILLUSKAN:     SetPCChatMessage(ProcessIlluskan(sMsg)); break;
        case LANGUAGE_IMASKAR:      SetPCChatMessage(ProcessImaskar(sMsg)); break;
        case LANGUAGE_INFERNAL:     SetPCChatMessage(ProcessInfernal(sMsg)); break;
        case LANGUAGE_IGNAN:        SetPCChatMessage(ProcessIgnan(sMsg)); break;
        case LANGUAGE_KOBOLD:       SetPCChatMessage(ProcessKobold(sMsg)); break;
        case LANGUAGE_KORRED:       SetPCChatMessage(ProcessKorred(sMsg)); break;
        case LANGUAGE_KUOTOAN:      SetPCChatMessage(ProcessKuoToan(sMsg)); break;
        case LANGUAGE_LANTANESE:    SetPCChatMessage(ProcessLantanese(sMsg)); break;
        case LANGUAGE_LIZARDMAN:    SetPCChatMessage(ProcessLizardMan(sMsg)); break;
        case LANGUAGE_MIDANI:       SetPCChatMessage(ProcessMidani(sMsg)); break;
        case LANGUAGE_MINOTAUR:     SetPCChatMessage(ProcessMinotaur(sMsg)); break;
        case LANGUAGE_MULHORANDI:   SetPCChatMessage(ProcessMulhorandi(sMsg)); break;
        case LANGUAGE_NEXALAN:      SetPCChatMessage(ProcessNexalan(sMsg)); break;
        case LANGUAGE_OGRE:         SetPCChatMessage(ProcessOgre(sMsg)); break;
        case LANGUAGE_OILLUSK:      SetPCChatMessage(ProcessOillusk(sMsg)); break;
        case LANGUAGE_ORCISH:       SetPCChatMessage(ProcessOrc(sMsg)); break;
        case LANGUAGE_PIXIE:        SetPCChatMessage(ProcessPixie(sMsg)); break;
        case LANGUAGE_RAKSHASA:     SetPCChatMessage(ProcessRakshasa(sMsg)); break;
        case LANGUAGE_RASHEMI:      SetPCChatMessage(ProcessRashemi(sMsg)); break;
        case LANGUAGE_RAUMVIRA:     SetPCChatMessage(ProcessRaumvira(sMsg)); break;
        case LANGUAGE_SAHAGUIN:     SetPCChatMessage(ProcessSahaguin(sMsg)); break;
        case LANGUAGE_SERUSAN:      SetPCChatMessage(ProcessSerusan(sMsg)); break;
        case LANGUAGE_SHAARAN:      SetPCChatMessage(ProcessShaaran(sMsg)); break;
        case LANGUAGE_SHOU:         SetPCChatMessage(ProcessShou(sMsg)); break;
        case LANGUAGE_STINGER:      SetPCChatMessage(ProcessStinger(sMsg)); break;
        case LANGUAGE_SVIRFNEBLIN:  SetPCChatMessage(ProcessSvirfneblin(sMsg)); break;
        case LANGUAGE_SYLVAN:       SetPCChatMessage(ProcessSylvan(sMsg)); break;
        case LANGUAGE_TALFIRIC:     SetPCChatMessage(ProcessTalfiric(sMsg)); break;
        case LANGUAGE_TASHALAN:     SetPCChatMessage(ProcessTashalan(sMsg)); break;
        case LANGUAGE_TERRAN:       SetPCChatMessage(ProcessTerran(sMsg)); break;
        case LANGUAGE_THRIKREEN:    SetPCChatMessage(ProcessThriKreen(sMsg)); break;
        case LANGUAGE_TREANT:       SetPCChatMessage(ProcessTreant(sMsg)); break;
        case LANGUAGE_TROLL:        SetPCChatMessage(ProcessTroll(sMsg)); break;
        case LANGUAGE_TUIGAN:       SetPCChatMessage(ProcessTuigan(sMsg)); break;
        case LANGUAGE_TURMIC:       SetPCChatMessage(ProcessTurmic(sMsg)); break;
        case LANGUAGE_ULUIK:        SetPCChatMessage(ProcessUluik(sMsg)); break;
        case LANGUAGE_UNDERCOMMON:  SetPCChatMessage(ProcessUndercommon(sMsg)); break;
        case LANGUAGE_UNTHERIC:     SetPCChatMessage(ProcessUntheric(sMsg)); break;
        case LANGUAGE_VAASAN:       SetPCChatMessage(ProcessVaasan(sMsg)); break;
        case LANGUAGE_YUANTI:       SetPCChatMessage(ProcessYuanTi(sMsg)); break;
    }

    string sName = GetName(oPC);
    string sLang = GetLanguageName(nLanguage);

    if(nVolume == TALKVOLUME_PARTY){
        object oListener = GetFirstFactionMember(oPC);

        while(GetIsObjectValid(oListener)){
            if(GetIsPC(oListener) && GetIsLanguageKnown(oListener, nLanguage)){
                SendMessageToPC(oListener, sName + " [" + sLang + "]: " + sMsg);
            }

            oListener = GetNextFactionMember(oPC);
        }
    } else {
        object oListener = GetFirstPC();

        float fDistance;

        switch(nVolume){
            case TALKVOLUME_TALK:    fDistance = 30.0; break;
            case TALKVOLUME_WHISPER: fDistance = 5.0;  break;
        }

        while(GetIsObjectValid(oListener)){
            if(GetIsPC(oListener) && GetIsLanguageKnown(oListener, nLanguage) &&
               GetDistanceBetween(oPC, oListener) < fDistance && GetArea(oPC) == GetArea(oListener)){
                SendMessageToPC(oListener, sName + " [" + sLang + "]: " + sMsg);
            }

            oListener = GetNextPC();
        }
    }
}

void SetActiveLanguage(object oPC, int nLanguage){
    if(nLanguage == LANGUAGE_COMMON) DeleteActiveLanguage(oPC);
    FloatingTextStringOnCreature("You are now speaking " + GetLanguageName(nLanguage) + ".", oPC, FALSE);
    SetLocalInt(oPC, "LANGUAGE_ACTIVE", nLanguage);
}

int GetActiveLanguage(object oPC){
    return GetLocalInt(oPC, "LANGUAGE_ACTIVE");
}

void DeleteActiveLanguage(object oPC){
    DeleteLocalInt(oPC, "LANGUAGE_ACTIVE");
}

string GetLanguageName(int nLanguage){
    switch(nLanguage){
        case LANGUAGE_ABYSSAL:      return "Abyssal";
        case LANGUAGE_ALGARONDAN:   return "Algarondan";
        case LANGUAGE_ALZHEDO:      return "Alzhedo";
        case LANGUAGE_AQUAN:        return "Aquan";
//        case LANGUAGE_ASSASSIN:     return "Assassin";             NEEDS TO BE READDED.
        case LANGUAGE_AURAN:        return "Auran";
        case LANGUAGE_AVERIAL:      return "Averial";
        case LANGUAGE_BUGBEAR:      return "Bugbear";
//        case LANGUAGE_CANT:         return "Cant";                 NEEDS TO BE READDED.
        case LANGUAGE_CELESTIAL:    return "Celestial";
        case LANGUAGE_CHESSENTAN:   return "Chessentan";
        case LANGUAGE_CHONDATHAN:   return "Chondathan";
        case LANGUAGE_CHULTAN:      return "Chultan";
        case LANGUAGE_COMMON:       return "Common";
        case LANGUAGE_DAMARAN:      return "Damaran";
        case LANGUAGE_DAMBRATHAN:   return "Dambrathan";
        case LANGUAGE_DRACONIC:     return "Draconic";
        case LANGUAGE_DROW:         return "Drow";
//        case LANGUAGE_DROW_SIGN:    return "DrowSign";             NEEDS TO BE READDED.
        case LANGUAGE_DRUIDIC:      return "Druidic";
        case LANGUAGE_DUERGAR:      return "Duergar";
        case LANGUAGE_DURPARI:      return "Durpari";
        case LANGUAGE_DWARVEN:      return "Dwarven";
        case LANGUAGE_ELVEN:        return "Elven";
        case LANGUAGE_GIANT:        return "Giant";
        case LANGUAGE_GITHZERAI:    return "Githzerai";
        case LANGUAGE_GNOLL:        return "Gnoll";
        case LANGUAGE_GNOMISH:      return "Gnome";
        case LANGUAGE_GOBLIN:       return "Goblin";
        case LANGUAGE_GRIMLOCK:     return "Grimlock";
        case LANGUAGE_HALARDRIM:    return "Halardrim";
        case LANGUAGE_HALFLING:     return "Halfling";
        case LANGUAGE_HALRUAAN:     return "Halruaan";
        case LANGUAGE_HENGEYOKAI:   return "Hengeyokai";
        case LANGUAGE_HIGH_SHOU:    return "High Shou";
        case LANGUAGE_HOBGOBLIN:    return "Hobgoblin";
        case LANGUAGE_ILLITHID:     return "Illithid";
        case LANGUAGE_ILLUSKAN:     return "Illuskan";
        case LANGUAGE_IMASKAR:      return "Imaskar";
        case LANGUAGE_INFERNAL:     return "Infernal";
        case LANGUAGE_IGNAN:        return "Ignan";
        case LANGUAGE_KOBOLD:       return "Kobold";
        case LANGUAGE_KORRED:       return "Korred";
        case LANGUAGE_KUOTOAN:      return "Kuo Toan";
        case LANGUAGE_LANTANESE:    return "Lantanese";
        case LANGUAGE_LIZARDMAN:    return "Lizardman";
        case LANGUAGE_MIDANI:       return "Midani";
        case LANGUAGE_MINOTAUR:     return "Minotaur";
        case LANGUAGE_MULHORANDI:   return "Mulhorandi";
        case LANGUAGE_NEXALAN:      return "Nexalan";
        case LANGUAGE_OGRE:         return "Ogre";
        case LANGUAGE_OILLUSK:      return "Oillusk";
        case LANGUAGE_ORCISH:       return "Orc";
        case LANGUAGE_PIXIE:        return "Pixie";
        case LANGUAGE_RAKSHASA:     return "Rakshasa";
        case LANGUAGE_RASHEMI:      return "Rashemi";
        case LANGUAGE_RAUMVIRA:     return "Raumvira";
        case LANGUAGE_SAHAGUIN:     return "Sahaguin";
        case LANGUAGE_SERUSAN:      return "Serusan";
        case LANGUAGE_SHAARAN:      return "Shaaran";
        case LANGUAGE_SHOU:         return "Shou";
        case LANGUAGE_STINGER:      return "Stinger";
        case LANGUAGE_SVIRFNEBLIN:  return "Svirfneblin";
        case LANGUAGE_SYLVAN:       return "Sylvan";
        case LANGUAGE_TALFIRIC:     return "Talfiric";
        case LANGUAGE_TASHALAN:     return "Tashalan";
        case LANGUAGE_TERRAN:       return "Terran";
        case LANGUAGE_THRIKREEN:    return "Thri-Kreen";
        case LANGUAGE_TREANT:       return "Treant";
        case LANGUAGE_TROLL:        return "Troll";
        case LANGUAGE_TUIGAN:       return "Tuigan";
        case LANGUAGE_TURMIC:       return "Turmic";
        case LANGUAGE_ULUIK:        return "Uluik";
        case LANGUAGE_UNDERCOMMON:  return "Undercommon";
        case LANGUAGE_UNTHERIC:     return "Untheric";
        case LANGUAGE_VAASAN:       return "Vaasan";
        case LANGUAGE_YUANTI:       return "Yuan-Ti";
    }

    return "INVALID LANGUAGE";
}

int GetLanguageFeat(int nLanguage){
    switch(nLanguage){
        case LANGUAGE_ABYSSAL:      return FEAT_LANGUAGE_ABYSSAL;
        case LANGUAGE_ALGARONDAN:   return FEAT_LANGUAGE_ALGARONDAN;
        case LANGUAGE_ALZHEDO:      return FEAT_LANGUAGE_ALZHEDO;
        case LANGUAGE_AQUAN:        return FEAT_LANGUAGE_AQUAN;
//        case LANGUAGE_ASSASSIN:     return FEAT_LANGUAGE_ASSASSIN;             NEEDS TO BE READDED.
        case LANGUAGE_AURAN:        return FEAT_LANGUAGE_AURAN;
        case LANGUAGE_AVERIAL:      return FEAT_LANGUAGE_AVERIAL;
        case LANGUAGE_BUGBEAR:      return FEAT_LANGUAGE_BUGBEAR;
//        case LANGUAGE_CANT:         return FEAT_LANGUAGE_CANT;                 NEEDS TO BE READDED.
        case LANGUAGE_CELESTIAL:    return FEAT_LANGUAGE_CELESTIAL;
        case LANGUAGE_CHESSENTAN:   return FEAT_LANGUAGE_CHESSENTAN;
        case LANGUAGE_CHONDATHAN:   return FEAT_LANGUAGE_CHONDATHAN;
        case LANGUAGE_CHULTAN:      return FEAT_LANGUAGE_CHULTAN;
        case LANGUAGE_COMMON:       return FEAT_LANGUAGE_COMMON;
        case LANGUAGE_DAMARAN:      return FEAT_LANGUAGE_DAMARAN;
        case LANGUAGE_DAMBRATHAN:   return FEAT_LANGUAGE_DAMBRATHAN;
        case LANGUAGE_DRACONIC:     return FEAT_LANGUAGE_DRACONIC;
        case LANGUAGE_DROW:         return FEAT_LANGUAGE_DROW;
//        case LANGUAGE_DROW_SIGN:    return FEAT_LANGUAGE_DROW_SIGN;             NEEDS TO BE READDED.
        case LANGUAGE_DRUIDIC:      return FEAT_LANGUAGE_DRUIDIC;
        case LANGUAGE_DUERGAR:      return FEAT_LANGUAGE_DUERGAR;
        case LANGUAGE_DURPARI:      return FEAT_LANGUAGE_DURPARI;
        case LANGUAGE_DWARVEN:      return FEAT_LANGUAGE_DWARVEN;
        case LANGUAGE_ELVEN:        return FEAT_LANGUAGE_ELVEN;
        case LANGUAGE_GIANT:        return FEAT_LANGUAGE_GIANT;
        case LANGUAGE_GITHZERAI:    return FEAT_LANGUAGE_GITHZERAI;
        case LANGUAGE_GNOLL:        return FEAT_LANGUAGE_GNOLL;
        case LANGUAGE_GNOMISH:      return FEAT_LANGUAGE_GNOMISH;
        case LANGUAGE_GOBLIN:       return FEAT_LANGUAGE_GOBLIN;
        case LANGUAGE_GRIMLOCK:     return FEAT_LANGUAGE_GRIMLOCK;
        case LANGUAGE_HALARDRIM:    return FEAT_LANGUAGE_HALARDRIM;
        case LANGUAGE_HALFLING:     return FEAT_LANGUAGE_HALFLING;
        case LANGUAGE_HALRUAAN:     return FEAT_LANGUAGE_HALRUAAN;
        case LANGUAGE_HENGEYOKAI:   return FEAT_LANGUAGE_HENGEYOKAI;
        case LANGUAGE_HIGH_SHOU:    return FEAT_LANGUAGE_HIGH_SHOU;
        case LANGUAGE_HOBGOBLIN:    return FEAT_LANGUAGE_HOBGOBLIN;
        case LANGUAGE_ILLITHID:     return FEAT_LANGUAGE_ILLITHID;
        case LANGUAGE_ILLUSKAN:     return FEAT_LANGUAGE_ILLUSKAN;
        case LANGUAGE_IMASKAR:      return FEAT_LANGUAGE_IMASKAR;
        case LANGUAGE_INFERNAL:     return FEAT_LANGUAGE_INFERNAL;
        case LANGUAGE_IGNAN:        return FEAT_LANGUAGE_IGNAN;
        case LANGUAGE_KOBOLD:       return FEAT_LANGUAGE_KOBOLD;
        case LANGUAGE_KORRED:       return FEAT_LANGUAGE_KORRED;
        case LANGUAGE_KUOTOAN:      return FEAT_LANGUAGE_KUOTOAN;
        case LANGUAGE_LANTANESE:    return FEAT_LANGUAGE_LANTANESE;
        case LANGUAGE_LIZARDMAN:    return FEAT_LANGUAGE_LIZARDMAN;
        case LANGUAGE_MIDANI:       return FEAT_LANGUAGE_MIDANI;
        case LANGUAGE_MINOTAUR:     return FEAT_LANGUAGE_MINOTAUR;
        case LANGUAGE_MULHORANDI:   return FEAT_LANGUAGE_MULHORANDI;
        case LANGUAGE_NEXALAN:      return FEAT_LANGUAGE_NEXALAN;
        case LANGUAGE_OGRE:         return FEAT_LANGUAGE_OGRE;
        case LANGUAGE_OILLUSK:      return FEAT_LANGUAGE_OILLUSK;
        case LANGUAGE_ORCISH:       return FEAT_LANGUAGE_ORCISH;
        case LANGUAGE_PIXIE:        return FEAT_LANGUAGE_PIXIE;
        case LANGUAGE_RAKSHASA:     return FEAT_LANGUAGE_RAKSHASA;
        case LANGUAGE_RASHEMI:      return FEAT_LANGUAGE_RASHEMI;
        case LANGUAGE_RAUMVIRA:     return FEAT_LANGUAGE_RAUMVIRA;
        case LANGUAGE_SAHAGUIN:     return FEAT_LANGUAGE_SAHAGUIN;
        case LANGUAGE_SERUSAN:      return FEAT_LANGUAGE_SERUSAN;
        case LANGUAGE_SHAARAN:      return FEAT_LANGUAGE_SHAARAN;
        case LANGUAGE_SHOU:         return FEAT_LANGUAGE_SHOU;
        case LANGUAGE_STINGER:      return FEAT_LANGUAGE_STINGER;
        case LANGUAGE_SVIRFNEBLIN:  return FEAT_LANGUAGE_SVIRFNEBLIN;
        case LANGUAGE_SYLVAN:       return FEAT_LANGUAGE_SYLVAN;
        case LANGUAGE_TALFIRIC:     return FEAT_LANGUAGE_TALFIRIC;
        case LANGUAGE_TASHALAN:     return FEAT_LANGUAGE_TASHALAN;
        case LANGUAGE_TERRAN:       return FEAT_LANGUAGE_TERRAN;
        case LANGUAGE_THRIKREEN:    return FEAT_LANGUAGE_THRIKREEN;
        case LANGUAGE_TREANT:       return FEAT_LANGUAGE_TREANT;
        case LANGUAGE_TROLL:        return FEAT_LANGUAGE_TROLL;
        case LANGUAGE_TUIGAN:       return FEAT_LANGUAGE_TUIGAN;
        case LANGUAGE_TURMIC:       return FEAT_LANGUAGE_TURMIC;
        case LANGUAGE_ULUIK:        return FEAT_LANGUAGE_ULUIK;
        case LANGUAGE_UNDERCOMMON:  return FEAT_LANGUAGE_UNDERCOMMON;
        case LANGUAGE_UNTHERIC:     return FEAT_LANGUAGE_UNTHERIC;
        case LANGUAGE_VAASAN:       return FEAT_LANGUAGE_VAASAN;
        case LANGUAGE_YUANTI:       return FEAT_LANGUAGE_YUANTI;
    }

    return -1;
}

int GetIsRegionalLanguage(int nLanguage){
    switch(nLanguage){
        case LANGUAGE_ALGARONDAN:
        case LANGUAGE_ALZHEDO:
        case LANGUAGE_CHESSENTAN:
        case LANGUAGE_CHONDATHAN:
        case LANGUAGE_CHULTAN:
        case LANGUAGE_DAMARAN:
        case LANGUAGE_DAMBRATHAN:
        case LANGUAGE_DURPARI:
        case LANGUAGE_HALARDRIM:
        case LANGUAGE_HALRUAAN:
        case LANGUAGE_HENGEYOKAI:
        case LANGUAGE_HIGH_SHOU:
        case LANGUAGE_ILLUSKAN:
        case LANGUAGE_IMASKAR:
        case LANGUAGE_LANTANESE:
        case LANGUAGE_MIDANI:
        case LANGUAGE_MULHORANDI:
        case LANGUAGE_NEXALAN:
        case LANGUAGE_OILLUSK:
        case LANGUAGE_RASHEMI:
        case LANGUAGE_RAUMVIRA:
        case LANGUAGE_SAHAGUIN:
        case LANGUAGE_SERUSAN:
        case LANGUAGE_SHAARAN:
        case LANGUAGE_SHOU:
        case LANGUAGE_TALFIRIC:
        case LANGUAGE_TASHALAN:
        case LANGUAGE_TUIGAN:
        case LANGUAGE_TURMIC:
        case LANGUAGE_ULUIK:
        case LANGUAGE_UNTHERIC:
        case LANGUAGE_VAASAN:
            return TRUE;
    }

    return FALSE;
}

int GetHasSpeakLanguages(object oPC){
    return GetLevelByClass(CLASS_TYPE_BARD, oPC) > 0;
}
