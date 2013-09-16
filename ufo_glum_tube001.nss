//Placed on a trigger's OnEnter event

#include "ufo_glum_ball001"
#include "engine"

void SpillSpawn(string sType, location lPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sType, lPlace, FALSE, "pickled_monster");
}

void main()
{
    int nGo = GetLocalInt(OBJECT_SELF, "IsFired");

    if(nGo == 0)
    {
        object oPC = GetEnteringObject();
        object oTube1 = GetNearestObjectByTag("ufo_guld_tube", oPC, 1);
        object oTube2 = GetNearestObjectByTag("ufo_guld_tube", oPC, 2);
        object oBall = GetNearestObjectByTag("spn_guld_ball", oPC);
        object oWP = GetNearestObjectByTag("WP_SPN_TUBES", oPC);
        effect eBurst = EffectVisualEffect(124);
        location lWP = GetLocation(oWP);
        int nRoll = d4();
        int nRero = d4();
        string sRes;

        if(GetIsObjectValid(oBall))
        {
            if(nRoll == 1)
            {
                sRes = "ufo_gld_pckl001";
                DelayCommand(2.0f, SpillSpawn(sRes, lWP));
            }

            else if(nRoll == 2)
            {
                sRes = "ufo_gld_pckl002";
                DelayCommand(2.0f, SpillSpawn(sRes, lWP));
            }

            else if(nRoll == 3)
            {
                sRes = "ufo_gld_pckl003";
                DelayCommand(2.0f, SpillSpawn(sRes, lWP));
            }

            else if(nRoll == 4)
            {
                sRes = "ufo_gld_pckl004";
                DelayCommand(2.0f, SpillSpawn(sRes, lWP));
            }

            if(nRero == 1)
            {
                sRes = "ufo_gld_pckl001";
                DelayCommand(2.0f, SpillSpawn(sRes, lWP));
            }

            else if(nRero == 2)
            {
                sRes = "ufo_gld_pckl002";
                DelayCommand(2.0f, SpillSpawn(sRes, lWP));
            }

            else if(nRero == 3)
            {
                sRes = "ufo_gld_pckl003";
                DelayCommand(2.0f, SpillSpawn(sRes, lWP));
            }

            else if(nRero == 4)
            {
                sRes = "ufo_gld_pckl004";
                DelayCommand(2.0f, SpillSpawn(sRes, lWP));
            }

            AssignCommand(oBall, ActionSpeakString("Movement detected!", TALKVOLUME_TALK));
            AssignCommand(oBall, FireTubeLightning(oTube1));
            AssignCommand(oBall, FireTubeLightning(oTube2));

            DelayCommand(1.0f, AssignCommand(oTube1, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBurst, oTube1)));
            DelayCommand(1.2f, AssignCommand(oTube2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBurst, oTube2)));
            DelayCommand(1.4f, AssignCommand(oTube1, PlaySound("as_cv_glasbreak3")));

            SetLocalInt(OBJECT_SELF, "IsFired", 1);
            DelayCommand(1200.0f, SetLocalInt(OBJECT_SELF, "IsFired", 0));
        }
    }
}
