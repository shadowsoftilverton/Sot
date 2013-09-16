#include "inc_spellbook"
#include "nwnx_funcs"
#include "nw_i0_plot"

int GetMasterSpell(int iChildSpell)
{
    int MyMaster=StringToInt(Get2DAString("spells","Master",iChildSpell));
    if(MyMaster>0)
    {
        return MyMaster;
    }
    else return iChildSpell;
}

int GetIsForbiddenSpell(int nSpell,int iMySchool)
{
    string iSpellSchool=Get2DAString("spells","School",nSpell);
    int OppositionRow=StringToInt(Get2DAString("spellschools","Opposition",iMySchool));
    if(OppositionRow>0)
    {
        string OppositionLetter=Get2DAString("spellschools","Letter",OppositionRow);
        if(iSpellSchool==OppositionLetter)
        return 1;
    }
    return 0;
}


void main()
{
    object oObserver=OBJECT_SELF;
    object oDemonstrator=GetSpellTargetObject();
    if(GetLocalInt(oDemonstrator,"ave_demonstrate")>0)
    {
        int iSpell=GetLocalInt(oDemonstrator,"ave_dem_id")-1;
        if(iSpell>0)
        {
            iSpell=GetMasterSpell(iSpell);
            int iLevel=StringToInt(Get2DAString("spells","Wiz_Sorc",iSpell));
            int iName=StringToInt(Get2DAString("spells","Name",iSpell));

            if((iLevel>((GetEffectiveCasterLevel(oObserver,CLASS_TYPE_WIZARD)+1)/2)))
                SendMessageToPC(oObserver,"You do not have enough wizard caster levels to learn "+GetStringByStrRef(iName));
            else
            {
                int nTimer=GetPersistentInt(oObserver,"ave_tutor_delay");
                if(nTimer==TUTOR_DELAY_COUNT)
                {
                    if((0==GetKnowsSpell(iSpell,oObserver,CLASS_TYPE_WIZARD)))
                    {
                        int iMySchool=GetWizardSpecialization(oObserver);
                        if (GetIsForbiddenSpell(iSpell,iMySchool))
                            SendMessageToPC(oObserver,"Specialist wizards cannot learn spells from their prohibited schools!");
                        else
                        {
                            if(GetGold(oObserver)>=iLevel*iLevel*iLevel)
                            {
                                SendMessageToPC(oObserver,"You spend "+IntToString(iLevel*iLevel*iLevel)+" for materials to learn this spell.");
                                TakeGold(iLevel*iLevel*iLevel,oObserver,TRUE);
                                SetPersistentInt(oObserver,"ave_tutor_delay",0);
                                //DelayCommand(TurnsToSeconds(TUTOR_DELAY_MINUTES),SetLocalInt(oObserver,"ave_tutor_delay",0));
                                int nRoll=d20(1);
                                int nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oObserver);
                                if(nRoll+nMod>=iLevel*3)
                                {
                                    SendMessageToPC(oObserver,"Intelligence roll "+IntToString(nRoll)+" + "+IntToString(nMod)+" vs DC "+IntToString(iLevel*3)+" success!");
                                    SendMessageToPC(oObserver,"You have learned the spell "+GetStringByStrRef(iName));
                                    SendMessageToPC(oDemonstrator,"You have taught the spell "+GetStringByStrRef(iName));
                                    AddKnownSpell(oObserver,CLASS_TYPE_WIZARD,iLevel,iSpell);
                                }
                                else SendMessageToPC(oObserver,"Intelligence roll "+IntToString(nRoll)+" + "+IntToString(nMod)+" vs DC "+IntToString(iLevel*3)+" failure!");
                            }
                            else SendMessageToPC(oObserver,"You do not have enough gold! Requires "+IntToString(iLevel*iLevel*iLevel)+" GP for the materials to learn this spell.");
                        }
                    }
                    else SendMessageToPC(oObserver,"You already know the spell "+GetStringByStrRef(iName));
                }
                else SendMessageToPC(oObserver,"You must wait "+IntToString((TUTOR_DELAY_MINUTES*TUTOR_DELAY_COUNT)-(TUTOR_DELAY_MINUTES*nTimer))+" more minutes before you are ready to learn a spell!");
            }
        }
        else SendMessageToPC(oObserver,"You must wait until after the demonstration spell has been cast before you learn it!");
    }
    else
    {
        SendMessageToPC(oObserver,"This creature is not demonstrating!");
    }
}
