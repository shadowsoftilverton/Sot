//::///////////////////////////////////////////////
//:: Tailoring - Modify Right Shin
//:: tlr_modrshin.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 8, 2004
//:://////////////////////////////////////////////
void main()
{
    SetLocalInt(OBJECT_SELF, "ToModify", ITEM_APPR_ARMOR_MODEL_RSHIN);
    SetLocalString(OBJECT_SELF, "2DAFile", "parts_shin");
}
