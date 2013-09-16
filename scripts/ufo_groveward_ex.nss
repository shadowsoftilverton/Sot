#include "engine"

void main()
{
    object oExit = GetExitingObject();
    effect eCycle = GetFirstEffect(oExit);

    while(GetIsEffectValid(eCycle))
    {
        if(GetEffectCreator(eCycle) == OBJECT_SELF)
        {
            RemoveEffect(oExit, eCycle);
        }

        eCycle = GetNextEffect(oExit);
    }
}
