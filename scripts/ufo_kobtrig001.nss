#include "engine"

void main()
{
    object oCaller = OBJECT_SELF;
    int nTriggered = GetLocalInt(oCaller, "Triggered");

    if(nTriggered == 0)
    {
        int nRoll = d3();
        int nAmbush = d6();

        SetLocalInt(oCaller, "Triggered", 1);
        DelayCommand(1800.0f, SetLocalInt(oCaller, "Triggered", 0));

        if(nRoll == 1)
        {
            ExecuteScript("ufo_kobtrap001", oCaller);

            if(nAmbush >= 3);
            {
                location lTrigger = GetLocation(oCaller);
                string sTrigger = GetTag(oCaller);
                string sNumber = GetStringRight(sTrigger, 3);
                string sWP = "AMB_KOB" + sNumber;
                object oWP = GetFirstObjectInShape(SHAPE_SPHERE, 30.0f, lTrigger, FALSE, OBJECT_TYPE_WAYPOINT);
                location lWP;

                while(GetTag(oWP) == sWP)
                {
                    lWP = GetLocation(oWP);
                    CreateObject(OBJECT_TYPE_CREATURE, "ufo_thk_kob001", lWP, TRUE);

                    oWP = GetNextObjectInShape(SHAPE_SPHERE, 30.0f, lTrigger, FALSE, OBJECT_TYPE_WAYPOINT);
                }
            }
        }

        else if(nRoll == 2)
        {
            ExecuteScript("ufo_kobtrap002", oCaller);

            if(nAmbush >= 3);
            {
                location lTrigger = GetLocation(oCaller);
                string sTrigger = GetTag(oCaller);
                string sNumber = GetStringRight(sTrigger, 3);
                string sWP = "AMB_KOB" + sNumber;
                object oWP = GetFirstObjectInShape(SHAPE_SPHERE, 30.0f, lTrigger, FALSE, OBJECT_TYPE_WAYPOINT);
                location lWP;

                while(GetTag(oWP) == sWP)
                {
                    lWP = GetLocation(oWP);
                    CreateObject(OBJECT_TYPE_CREATURE, "ufo_thk_kob001", lWP, TRUE);

                    oWP = GetNextObjectInShape(SHAPE_SPHERE, 30.0f, lTrigger, FALSE, OBJECT_TYPE_WAYPOINT);
                }
            }
        }

        else if(nRoll == 3)
        {
            ExecuteScript("ufo_kobtrap003", oCaller);

            if(nAmbush >= 3);
            {
                location lTrigger = GetLocation(oCaller);
                string sTrigger = GetTag(oCaller);
                string sNumber = GetStringRight(sTrigger, 3);
                string sWP = "AMB_KOB" + sNumber;
                object oWP = GetFirstObjectInShape(SHAPE_SPHERE, 30.0f, lTrigger, FALSE, OBJECT_TYPE_WAYPOINT);
                location lWP;

                while(GetTag(oWP) == sWP)
                {
                    lWP = GetLocation(oWP);
                    CreateObject(OBJECT_TYPE_CREATURE, "ufo_thk_kob001", lWP, TRUE);

                    oWP = GetNextObjectInShape(SHAPE_SPHERE, 30.0f, lTrigger, FALSE, OBJECT_TYPE_WAYPOINT);
                }
            }
        }
    }
}
