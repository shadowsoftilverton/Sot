//:://////////////////////////////////////////////
//::  BODY TAILOR:  modify ...
//::                            onconv bodytailor
//:://////////////////////////////////////////////
/*
   sets the system to know what part to change
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: based on the Mil_Tailor by Milambus Mandragon
//:://////////////////////////////////////////////


void main()
{
    SetLocalString(OBJECT_SELF, "ToModify", "HAIR");
    SetLocalString(OBJECT_SELF, "2DAFile", "");
    SetCustomToken(91154, "Hair");

}
