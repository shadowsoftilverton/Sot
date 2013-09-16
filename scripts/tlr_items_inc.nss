//::///////////////////////////////////////////////
//:: Tailoring - Items Include File
//:: tlr_items_inc.nss
//::
//:://////////////////////////////////////////////
/*
    Includes functions for scrolling through and
    recoloring equipped items
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 28, 2006
//:: Edited by 420 for CEP where indicated
//:://////////////////////////////////////////////

const int    PART_NEXT  = 0;
const int    PART_PREV  = 1;
const int    COLOR_NEXT = 3;
const int    COLOR_PREV = 4;
const int    HELMET = 8888;
const int    SHIELD = 8889;

int GetIsShieldInvalid(int nCurrApp, int nBaseType);
int GetIsWeaponInvalid(int nCurrApp, int nBaseType, int nPart);

//Cloak crafting added for CEP
void RemakeCloak(object oNPC, object oItem, int nMode)
{
    int nCurrApp, nSlot;
    object oNew;

        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
        int nMin = 1;
        int nMax = 357;

        do
        {
            if (nMode == PART_NEXT)
            {
                if (++nCurrApp>nMax) nCurrApp = nMin;
            }
            else
            {
                if (--nCurrApp<nMin) nCurrApp = nMax;
            }

         }
         while (Get2DAString("cloakmodel", "LABEL", nCurrApp) == "");

    oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
            nSlot = INVENTORY_SLOT_CLOAK;


    if (GetIsObjectValid(oNew))
    {
        DestroyObject(oItem);
        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, ActionEquipItem(oNew, nSlot));
    }
        object oPC = GetPCSpeaker();
        SendMessageToPC(oPC, "New Appearance: " + IntToString(nCurrApp) +" "+ Get2DAString("cloakmodel", "LABEL", nCurrApp));
}

void RemakeShield(object oNPC, object oItem, int nMode)
{
///////////////////////////////////////////////////////////////////
/*
   Change the following values to the highest shield model
   numbers used in your module.  The default NWN values (no haks)
   are already listed.
*/
///////////////////////////////////////////////////////////////////

    int MaxSmallShield = 88;
    int MaxLargeShield = 255;
    int MaxTowerShield = 237; //CEP 2.1 Tower Shield Max

///////////////////////////////////////////////////////////////////

    int nSlot;
    object oNew;

    int nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
    int nBaseType = GetBaseItemType(oItem);
    int nMin = 11;
    int nMax;
    if(nBaseType == BASE_ITEM_SMALLSHIELD)
        nMax = MaxSmallShield;
    if(nBaseType == BASE_ITEM_LARGESHIELD)
        nMax = MaxLargeShield;
    if(nBaseType == BASE_ITEM_TOWERSHIELD)
        nMax = MaxTowerShield;
    do
    {
        if (nMode == PART_NEXT)
        {
            if (++nCurrApp > nMax)
                nCurrApp = nMin;
        }
        else
        {
            if (--nCurrApp < nMin)
                nCurrApp = nMax;
        }
        while(GetIsShieldInvalid(nCurrApp, nBaseType))
        {
            if (nMode == PART_NEXT)
                nCurrApp++;
            else
                nCurrApp--;
        }
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nCurrApp, TRUE);
    }
    while (!GetIsObjectValid(oNew));
        nSlot = INVENTORY_SLOT_LEFTHAND;

    if (GetIsObjectValid(oNew))
    {
        DestroyObject(oItem);
        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, ActionEquipItem(oNew, nSlot));
    }
        object oPC = GetPCSpeaker();
        SendMessageToPC(oPC, "New Appearance: " + IntToString(nCurrApp));
}

void RemakeHelm(object oModel, object oItem, int nMode)
{
    int nCurrApp, nSlot;
    object oNew;

        nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0);
        int nMin = 1;
        int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", BASE_ITEM_HELMET));

        do
        {
            if (nMode == PART_NEXT)
            {
                if (++nCurrApp>nMax) nCurrApp = nMin;
            }
            else
            {
                if (--nCurrApp<nMin) nCurrApp = nMax;
            }

            oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, 0, nCurrApp, TRUE);
         }
         while (!GetIsObjectValid(oNew));
            nSlot = INVENTORY_SLOT_HEAD;


    if (GetIsObjectValid(oNew))
    {
        DestroyObject(oItem);
        AssignCommand(oModel, ClearAllActions(TRUE));
        AssignCommand(oModel, ActionEquipItem(oNew, nSlot));
    }
        object oPC = GetPCSpeaker();
        SendMessageToPC(oPC, "New Appearance: " + IntToString(nCurrApp));
}

void RemakeWeapon(object oNPC, object oItem, int nPart, int nMode)
{
    object oNew;
    int nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, nPart);
    int nBaseType = GetBaseItemType(oItem);
    /*int nMin = StringToInt(Get2DAString("baseitems", "MinRange", nBaseType)) /10*/;
    /*int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", nBaseType)) /10*/;
    int nMin = 1;
    int nMax = 255;
    do
    {
        if (nMode == PART_NEXT)
        {
            if (++nCurrApp>nMax)
                nCurrApp = nMin;
        }
        else
        {
            if (--nCurrApp<nMin)
                nCurrApp = nMax;
        }
        while(GetIsWeaponInvalid(nCurrApp, nBaseType, nPart))
        {
            if (nMode == PART_NEXT)
                nCurrApp++;
            else
                nCurrApp--;
        }
        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, nPart, nCurrApp, TRUE);
     }
     while (!GetIsObjectValid(oNew));
        int nSlot = INVENTORY_SLOT_RIGHTHAND;


    if (GetIsObjectValid(oNew))
    {
        DestroyObject(oItem);
        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, ActionEquipItem(oNew, nSlot));
    }
        object oPC = GetPCSpeaker();
        SendMessageToPC(oPC, "New Appearance: " + IntToString(nCurrApp));
}

void ColorItem(object oNPC, object oItem, int nPart, int nMode)
{
    int nCurrApp, nSlot;
    object oNew;

    nCurrApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, nPart);
    int nMin = 1;
    int nMax = 4;

    do
    {
        if (nMode == COLOR_NEXT)
        {
            if (++nCurrApp>nMax) nCurrApp = nMin;
        }
        else
        {
            if (--nCurrApp<nMin) nCurrApp = nMax;
        }

        oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, nPart, nCurrApp, TRUE);
        nSlot = INVENTORY_SLOT_RIGHTHAND;
    } while (!GetIsObjectValid(oNew));
    if (GetIsObjectValid(oNew))
    {
        DestroyObject(oItem);
        oItem = oNew;
        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, ActionEquipItem(oItem, nSlot));
        object oPC = GetPCSpeaker();
        SendMessageToPC(oPC, "New Color: " + IntToString(nCurrApp));

    }
}

/*
///////////////////////////////////////////////////////
   Invalid Model Numbers and Restriction List
///////////////////////////////////////////////////////

   To Restrict Individual Numbers:
   Place a list of case statements above the return TRUE; line.
   ie:
        case 1:
        case 53:
        case 42:
            return TRUE;

  To Restrict Number Ranges:
  Replace the [low#] and [high#] with your starting and ending numbers
  (inclusive), in the if statement.  Copy the base if statment for more
  ranges.
  ie, to exclude 1, 2, 3, 4, and 5:

       if( nBaseType >= 1 && nBaseType <= 5)
           return TRUE;

  To Find the Numbers to Restrict:

      Shields:
      Edit a small, large, and tower shield in the toolset and mark
      which shield model numbers are missing for each shield type.  Also note
      down any shield model number you do not want players to be able
      to use, and put the unwanted numbers into the above format in the
      GetIsShieldInvalid function.

      Weapons:
      Follow the above method for weapons to determine which model numbers
      you don't want to allow.

*/
int GetIsShieldInvalid(int nCurrApp, int nBaseType)
{
// shield code modified 22/AUG/2006 by SJGL
// Edited by 420 for CEP 2.x to use cepshieldmodel.2da
////////////////////////////////////////////////////////////////
//                       Small Shields
////////////////////////////////////////////////////////////////
    if(nBaseType == BASE_ITEM_SMALLSHIELD)
    {
/*      Place restricted numbers here and uncomment as neccessary
        switch(nCurrApp)
        {
            case 1:
            case 53:
            case 42:
                return TRUE;
        }

        if( nCurrApp >= 1 && nCurrApp <= 5)
            return TRUE;
*/
        if(Get2DAString("cepshieldmodel", "BASE_ITEM_SMALLSHIELD", nCurrApp) == "")
            return TRUE;
        return FALSE;
    }

////////////////////////////////////////////////////////////////
//                       Large Shields
////////////////////////////////////////////////////////////////
    if(nBaseType == BASE_ITEM_LARGESHIELD)
    {
/*      Place restricted numbers here and uncomment as neccessary
        switch(nCurrApp)
        {
            case 1:
            case 53:
            case 42:
                return TRUE;
        }

        if( nCurrApp >= 1 && nCurrApp <= 5)
            return TRUE;
*/
        if(Get2DAString("cepshieldmodel", "BASE_ITEM_LARGESHIELD", nCurrApp) == "")
            return TRUE;
        return FALSE;
   }

////////////////////////////////////////////////////////////////
//                       Tower Shields
////////////////////////////////////////////////////////////////
    if(nBaseType == BASE_ITEM_TOWERSHIELD)
    {
/*      Place restricted numbers here and uncomment as neccessary

        //To restrict individual numbers, replace #
        //with the number to restrict
        switch(nCurrApp)
        {
            case #:
            case #:
            case #:
                return TRUE;
        }

        //To restrict individual numbers, replace #
        //with the lowest and highest number to restrict (inclusive)
        if(nCurrApp >= # && nCurrApp <= #)
            return TRUE;
*/
        if(Get2DAString("cepshieldmodel", "BASE_ITEM_TOWERSHIELD", nCurrApp) == "")
            return TRUE;
        return FALSE;
    }
return FALSE;
}
int GetIsWeaponInvalid(int nCurrApp, int nBaseType, int nPart)
{
/*
//    Uncomment and fill out as neccessary.  Change **** to the base item
//    type you are wanting to disallow models from.  You can type
//    "BASE_ITEM_" in the filter to the right, and click the Constants button
//    to see a list.  For example: BASE_ITEM_DAGGER, BASE_ITEM_CLUB, etc.
//    Copy and paste the below template if you are wanting to restrict models
//    from more than one item type.

      //Weapon Top Restrictions
      if(nPart == ITEM_APPR_WEAPON_MODEL_TOP)
      {
          if(nBaseType == BASE_ITEM_****)
          {
              //To restrict individual numbers, replace #
              //with the number to restrict
              switch(nCurrApp)
              {
                  case #:
                  case #:
                  case #:
                      return TRUE;
              }
              //To restrict individual numbers, replace #
              //with the lowest and highest number to restrict (inclusive)
              if(nCurrApp >= # && nCurrApp <= #)
                  return TRUE;
          }
      }

      //Weapon Middle Restrictions
      if(nPart == ITEM_APPR_WEAPON_MODEL_MIDDLE)
      {
          if(nBaseType == BASE_ITEM_****)
          {
              //To restrict individual numbers, replace #
              //with the number to restrict
              switch(nCurrApp)
              {
                  case #:
                  case #:
                  case #:
                      return TRUE;
              }
              //To restrict individual numbers, replace #
              //with the lowest and highest number to restrict (inclusive)
              if(nCurrApp >= # && nCurrApp <= #)
                  return TRUE;
          }
      }

      //Weapon Bottom Restrictions
      if(nPart == ITEM_APPR_WEAPON_MODEL_BOTTOM)
      {
          if(nBaseType == BASE_ITEM_****)
          {
              //To restrict individual numbers, replace #
              //with the number to restrict
              switch(nCurrApp)
              {
                  case #:
                  case #:
                  case #:
                      return TRUE;
              }
              //To restrict individual numbers, replace #
              //with the lowest and highest number to restrict (inclusive)
              if(nCurrApp >= # && nCurrApp <= #)
                  return TRUE;
          }
      }
*/
      return FALSE;
}

