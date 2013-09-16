#include "zzdlg_main_inc"
#include "zzdlg_tools_inc"

#include "inc_arrays"
#include "inc_spellbook"
#include "inc_strings"

#include "uw_inc"

const string VAR_CLASS_SELECT = "zzdlg_var_class_select";
const string VAR_SPELL_LEVEL  = "zzdlg_var_spell_lvl";
const string VAR_SPELL_LIST   = "zzdlg_var_spell_list";
const string VAR_SPELL_SELECT = "zzdlg_var_spell_select";

const string PAGE_MAIN              = "PAGE_MAIN";
const string PAGE_SPELLBOOK_INDEX   = "PAGE_SPELLBOOK_INDEX";
const string PAGE_SPELL_SELECT      = "PAGE_SPELL_SELECT";
const string PAGE_SPELL_DESCRIPTION = "PAGE_SPELL_DESCRIPTION";

const string SELECT_GENERAL_BACK = "Back.";

const string SELECT_CLASS_BARD = "Bard.";
const string SELECT_CLASS_SORCERER = "Sorcerer.";
const string SELECT_CLASS_WIZARD = "Wizard.";

const string SELECT_SPELL_LEARN = "Yes, learn this spell.";

void OnInit( ){
    dlgChangeLabelNext(ColorString("Next Page >>", 255, 255, 55));
    dlgChangeLabelPrevious(ColorString("<< Previous Page", 255, 255, 55));

    dlgChangePage( PAGE_MAIN );
}

// Create the page
void OnPageInit( string sPage ){
    object oPC = dlgGetSpeakingPC();

//--------------------------------MAIN PAGE-----------------------------------//
    if(sPage == PAGE_MAIN){
        dlgClearResponseList(PAGE_MAIN);

        dlgSetPrompt("Which spellbook would you like to modify?");

        if(GetHasUnlearnedSpells(oPC, CLASS_TYPE_BARD))     dlgAddResponse(PAGE_MAIN, SELECT_CLASS_BARD);
        if(GetHasUnlearnedSpells(oPC, CLASS_TYPE_SORCERER)) dlgAddResponse(PAGE_MAIN, SELECT_CLASS_SORCERER);
        if(GetHasUnlearnedSpells(oPC, CLASS_TYPE_WIZARD))   dlgAddResponse(PAGE_MAIN, SELECT_CLASS_WIZARD);

        dlgActivateEndResponse(ColorString("Exit.", 255, 55, 55));

        dlgSetActiveResponseList(PAGE_MAIN);
    } else
//----------------------------------------------------------------------------//

//------------------------------SPELLBOOK INDEX-------------------------------//
    if(sPage == PAGE_SPELLBOOK_INDEX){
        dlgClearResponseList(PAGE_SPELLBOOK_INDEX);

        string sClass, sPage;
        int nSpellLevels, nLowestLevel;

        int nClass = dlgGetPlayerDataInt(VAR_CLASS_SELECT);

        switch(nClass){
            case CLASS_TYPE_BARD:
                sClass = "bard";
                nSpellLevels = 6;
                nLowestLevel = 0;
            break;

            case CLASS_TYPE_SORCERER:
                sClass = "sorcerer";
                nSpellLevels = 9;
                nLowestLevel = 0;
            break;

            case CLASS_TYPE_WIZARD:
                sClass = "wizard";
                nSpellLevels = 9;
                nLowestLevel = 0;
            break;
        }

        dlgSetPrompt("Which " + sClass + " spell level would you like to modify?");

        int i;

        for(i = nLowestLevel; i <= nSpellLevels; i++){
            if(GetUnlearnedSpells(oPC, nClass, i) > 0) dlgAddResponse(PAGE_SPELLBOOK_INDEX, "Spell Level " + IntToString(i) + ".");
        }

        dlgAddResponse(PAGE_SPELLBOOK_INDEX, SELECT_GENERAL_BACK);

        dlgSetActiveResponseList(PAGE_SPELLBOOK_INDEX);
    } else
//----------------------------------------------------------------------------//

//-----------------------------SPELL SELECTION--------------------------------//
    if(sPage == PAGE_SPELL_SELECT){
        dlgClearResponseList(PAGE_SPELL_SELECT);

        int nClass = dlgGetPlayerDataInt(VAR_CLASS_SELECT);
        int nSpellLevel = dlgGetPlayerDataInt(VAR_SPELL_LEVEL);

        dlgSetPrompt("You have " + ColorString(IntToString(GetUnlearnedSpells(oPC, nClass, nSpellLevel)), 55, 255, 55) +
                     " unlearned spells remaining.");

        int i = 0;

        string aSpells = GetSpellsBySpellLevel(nClass, nSpellLevel);

        string sIter = GetArrayElement(aSpells, i++);

        while(sIter != ""){
            int nSpell = StringToInt(sIter);

            if(!GetKnowsSpell(nSpell, oPC, nClass)){
                dlgAddResponse(PAGE_SPELL_SELECT, GetStringByStrRef(Get2DAInt("spells", "Name", nSpell)));
                sIter = GetArrayElement(aSpells, i++);
            } else {
                aSpells = RemoveArrayElement(aSpells, i - 1);
                sIter = GetArrayElement(aSpells, i - 1);
            }
        }

        dlgSetPlayerDataString(VAR_SPELL_LIST, aSpells);

        dlgAddResponse(PAGE_SPELL_SELECT, SELECT_GENERAL_BACK);

        dlgSetActiveResponseList(PAGE_SPELL_SELECT);
    } else
//----------------------------------------------------------------------------//

//------------------------------SPELL DESCRIPTION-----------------------------//
    if(sPage == PAGE_SPELL_DESCRIPTION){
        dlgClearResponseList(PAGE_SPELL_DESCRIPTION);

        dlgSetPrompt(GetStringByStrRef(Get2DAInt("spells", "SpellDesc", dlgGetPlayerDataInt(VAR_SPELL_SELECT))));

        dlgAddResponse(PAGE_SPELL_DESCRIPTION, SELECT_SPELL_LEARN);

        dlgAddResponse(PAGE_SPELL_DESCRIPTION, SELECT_GENERAL_BACK);

        dlgSetActiveResponseList(PAGE_SPELL_DESCRIPTION);
    }
//----------------------------------------------------------------------------//
}

void OnSelection( string sPage )
{
    object oPC = dlgGetSpeakingPC();

    string sSelect = dlgGetSelectionName();
    int nSelect = dlgGetSelectionIndex();

//--------------------------------MAIN PAGE-----------------------------------//
    if(sPage == PAGE_MAIN){
        if(dlgIsSelectionEqualToName(SELECT_CLASS_BARD)){
            dlgSetPlayerDataInt(VAR_CLASS_SELECT, CLASS_TYPE_BARD);
        } else if(dlgIsSelectionEqualToName(SELECT_CLASS_SORCERER)){
            dlgSetPlayerDataInt(VAR_CLASS_SELECT, CLASS_TYPE_SORCERER);
        } else if(dlgIsSelectionEqualToName(SELECT_CLASS_WIZARD)){
            dlgSetPlayerDataInt(VAR_CLASS_SELECT, CLASS_TYPE_WIZARD);
        }

        dlgChangePage(PAGE_SPELLBOOK_INDEX);
    } else
//----------------------------------------------------------------------------//

//----------------------------SPELLBOOK INDEX---------------------------------//
    if (sPage == PAGE_SPELLBOOK_INDEX){
        if(dlgIsSelectionEqualToName(SELECT_GENERAL_BACK)){
            dlgChangePage(PAGE_MAIN);
        } else {
            dlgSetPlayerDataInt(VAR_SPELL_LEVEL, StringToInt(GetStringLeft(GetStringRight(sSelect, 2), 1)));
            dlgChangePage(PAGE_SPELL_SELECT);
        }
    } else
//----------------------------------------------------------------------------//

//-----------------------------SPELL SELECTION--------------------------------//
    if(sPage == PAGE_SPELL_SELECT){
        if(dlgIsSelectionEqualToName(SELECT_GENERAL_BACK)){
            dlgChangePage(PAGE_SPELLBOOK_INDEX);
        } else {
            string aArray = dlgGetPlayerDataString(VAR_SPELL_LIST);

            dlgSetPlayerDataInt(VAR_SPELL_SELECT, StringToInt(GetArrayElement(aArray, nSelect)));

            dlgChangePage(PAGE_SPELL_DESCRIPTION);
        }
    } else

//----------------------------------------------------------------------------//

//-----------------------------SPELL DESCRIPTION-------------------------------//
    if(sPage == PAGE_SPELL_DESCRIPTION){
        if(dlgIsSelectionEqualToName(SELECT_GENERAL_BACK)){
            dlgChangePage(PAGE_SPELL_SELECT);
        } else if(dlgIsSelectionEqualToName(SELECT_SPELL_LEARN)) {
            int nClass = dlgGetPlayerDataInt(VAR_CLASS_SELECT);
            int nSpell = dlgGetPlayerDataInt(VAR_SPELL_SELECT);
            int nLevel = dlgGetPlayerDataInt(VAR_SPELL_LEVEL);

            AddPersistentSpell(oPC, nClass, dlgGetPlayerDataInt(VAR_SPELL_LEVEL), nSpell);

            if(GetUnlearnedSpells(oPC, nClass, nLevel) > 0){
                dlgChangePage(PAGE_SPELL_SELECT);
            } else {
                dlgChangePage(PAGE_SPELLBOOK_INDEX);
            }
        }
    }
//----------------------------------------------------------------------------//
}

void OnReset( string sPage )
{
}

void OnAbort( string sPage ){
}

void OnEnd( string sPage ){
    object oPC = dlgGetSpeakingPC();

    AssignCommand(oPC, ActionStartConversation(oPC, UW_MENU, TRUE, FALSE));
}

void OnContinue( string sPage, int iContinuePage )
{
}

// Let dlg_wrapper tell us which event fired. (Required)
void main()
{
    dlgOnMessage();
}
