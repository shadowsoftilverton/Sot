#include "engine"

#include "inc_language"

void main()
{
    object oPC = GetPCSpeaker();

    LearnLanguage(oPC, LANGUAGE_CHESSENTAN);
}
