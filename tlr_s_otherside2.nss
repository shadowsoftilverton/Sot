//::///////////////////////////////////////////////
//:: TAILOR: symmetry, copy from the other side
//::                                           onconv mil_tailor
//:://////////////////////////////////////////////
/*
  is it symmetrical?
  read # from other side

*/
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//-- cobbled from milambus's scripts
//-- milamBUS, one day, i'll learn his name right!
//--(i suck at names, k?)
//:://////////////////////////////////////////////



void main()
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);
    int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");
    int iSource;
    //-- step zero: translate our toModify
    switch (iToModify)
    {
      case ITEM_APPR_ARMOR_MODEL_RBICEP: {  iSource = ITEM_APPR_ARMOR_MODEL_LBICEP; break; }
      case ITEM_APPR_ARMOR_MODEL_RFOOT: {  iSource = ITEM_APPR_ARMOR_MODEL_LFOOT; break; }
      case ITEM_APPR_ARMOR_MODEL_RFOREARM: {  iSource = ITEM_APPR_ARMOR_MODEL_LFOREARM; break; }
      case ITEM_APPR_ARMOR_MODEL_RHAND: {  iSource = ITEM_APPR_ARMOR_MODEL_LHAND; break; }
      case ITEM_APPR_ARMOR_MODEL_RSHIN: {  iSource = ITEM_APPR_ARMOR_MODEL_LSHIN; break; }
      case ITEM_APPR_ARMOR_MODEL_RSHOULDER: {  iSource = ITEM_APPR_ARMOR_MODEL_LSHOULDER; break; }
      case ITEM_APPR_ARMOR_MODEL_RTHIGH: {  iSource = ITEM_APPR_ARMOR_MODEL_LTHIGH; break; }
      case ITEM_APPR_ARMOR_MODEL_LBICEP: {  iSource = ITEM_APPR_ARMOR_MODEL_RBICEP; break; }
      case ITEM_APPR_ARMOR_MODEL_LFOOT: {  iSource = ITEM_APPR_ARMOR_MODEL_RFOOT; break; }
      case ITEM_APPR_ARMOR_MODEL_LFOREARM: {  iSource = ITEM_APPR_ARMOR_MODEL_RFOREARM; break; }
      case ITEM_APPR_ARMOR_MODEL_LHAND: {  iSource = ITEM_APPR_ARMOR_MODEL_RHAND; break; }
      case ITEM_APPR_ARMOR_MODEL_LSHIN: {  iSource = ITEM_APPR_ARMOR_MODEL_RSHIN; break; }
      case ITEM_APPR_ARMOR_MODEL_LSHOULDER: {  iSource = ITEM_APPR_ARMOR_MODEL_RSHOULDER; break; }
      case ITEM_APPR_ARMOR_MODEL_LTHIGH: {  iSource = ITEM_APPR_ARMOR_MODEL_RTHIGH; break; }

      default:  return;   //-- not a symmetrical part
    }

    int iNewApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify);

    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iSource, iNewApp, TRUE);

    DestroyObject(oItem);

    DelayCommand(0.5f, AssignCommand(OBJECT_SELF, ActionEquipItem(oNewItem, INVENTORY_SLOT_CHEST)));

}
