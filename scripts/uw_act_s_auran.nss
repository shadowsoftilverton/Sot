#include "engine"

#include "inc_language"

void main(){
    object oPC = GetPCSpeaker();
    SetActiveLanguage(oPC, LANGUAGE_AURAN);
}
