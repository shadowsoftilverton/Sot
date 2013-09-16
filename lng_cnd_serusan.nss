#include "engine"

#include "inc_language"

int StartingConditional(){
    object oPC = GetPCSpeaker();
    return !GetIsLanguageKnown(oPC, LANGUAGE_SERUSAN);
}
