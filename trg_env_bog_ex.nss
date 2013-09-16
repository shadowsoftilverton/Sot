/*
    OnExit bog script
    by Hardcore UFO
    Removes things done by trg_env_bog_en
*/

#include "engine"

void main()
{
    object oExit = GetExitingObject();
    string sCreator = GetTag(OBJECT_SELF);
    object oCreator = GetObjectByTag(sCreator);
    effect eCycle = GetFirstEffect(oExit);

    while(GetIsEffectValid(eCycle))
    {
        if(GetEffectCreator(eCycle) == oCreator)
        {
            Std_RemoveEffect(oExit, eCycle);
            break;
        }

        eCycle = GetNextEffect(oExit);
    }
}
