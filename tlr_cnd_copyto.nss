int StartingConditional()
{
    int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");

    return iToModify == ITEM_APPR_ARMOR_MODEL_LBICEP    ||
           iToModify == ITEM_APPR_ARMOR_MODEL_LFOOT     ||
           iToModify == ITEM_APPR_ARMOR_MODEL_LFOREARM  ||
           iToModify == ITEM_APPR_ARMOR_MODEL_LHAND     ||
           iToModify == ITEM_APPR_ARMOR_MODEL_LSHIN     ||
           iToModify == ITEM_APPR_ARMOR_MODEL_LSHOULDER ||
           iToModify == ITEM_APPR_ARMOR_MODEL_LTHIGH    ||
           iToModify == ITEM_APPR_ARMOR_MODEL_RBICEP    ||
           iToModify == ITEM_APPR_ARMOR_MODEL_RFOOT     ||
           iToModify == ITEM_APPR_ARMOR_MODEL_RFOREARM  ||
           iToModify == ITEM_APPR_ARMOR_MODEL_RHAND     ||
           iToModify == ITEM_APPR_ARMOR_MODEL_RSHIN     ||
           iToModify == ITEM_APPR_ARMOR_MODEL_RSHOULDER ||
           iToModify == ITEM_APPR_ARMOR_MODEL_RTHIGH;
}
