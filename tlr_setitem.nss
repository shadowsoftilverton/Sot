//::///////////////////////////////////////////////
//:: Tailoring - Set Item
//:: tlr_setitem.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 9, 2004
//-- bloodsong adds restriction lists
//:: Edited by 420 for CEP where indicated
//:://////////////////////////////////////////////
#include "tlr_include"

#include "inc_conversation"

// Get a Cached 2DA string, and if its not cached read it from the 2DA file and cache it.
string GetCachedACBonus(string sFile, int iRow);

void main()
{
    //Removed for CEP, GetSpokenPart function handles it now
    //SetListening(OBJECT_SELF, FALSE);

    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);

    int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");

    //int iNewApp = StringToInt(GetLocalString(OBJECT_SELF, "tlr_Spoken"));

    //Fixed the line above for CEP
    //-- this is set by the tlr_listenon script, which has to go in the creature conv slot
    int iNewApp = StringToInt(GetConversationInput(oPC));

    if (iNewApp < 0) iNewApp = 0;

//-- valid pieces check zone vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

    int nGender = GetGender(OBJECT_SELF);
    string s2DAFile = GetLocalString(OBJECT_SELF, "2DAFile");
    string s2DA_ACBonus;

  if(iToModify == ITEM_APPR_ARMOR_MODEL_NECK)
  {//-- check for valid part
     while(NeckIsInvalid(iNewApp, nGender))
     {//-- increase
       iNewApp++;
       //-- check we didnt hit the end
       s2DA_ACBonus = GetCachedACBonus(s2DAFile, iNewApp);
       if (s2DA_ACBonus == "FAIL")
       {//-- if so, loop back to 1
          iNewApp = 1;
       }
     }
  }

  if(iToModify == ITEM_APPR_ARMOR_MODEL_TORSO)
  {//-- check for valid part
     while(TorsoIsInvalid(iNewApp, nGender))
     {//-- increase
       iNewApp++;
       //-- check we didnt hit the end
       s2DA_ACBonus = GetCachedACBonus(s2DAFile, iNewApp);
       if (s2DA_ACBonus == "FAIL")
       {//-- if so, loop back to 1
          iNewApp = 1;
       }
     }
  }


  if(iToModify == ITEM_APPR_ARMOR_MODEL_BELT)
  {//-- check for valid part
     while(BeltIsInvalid(iNewApp, nGender))
     {//-- increase
       iNewApp++;
       //-- check we didnt hit the end
       s2DA_ACBonus = GetCachedACBonus(s2DAFile, iNewApp);
       if (s2DA_ACBonus == "FAIL")
       {//-- if so, loop back to 1
          iNewApp = 1;
       }
     }
  }

  if(iToModify == ITEM_APPR_ARMOR_MODEL_PELVIS)
  {//-- check for valid part
     while(HipIsInvalid(iNewApp, nGender))
     {//-- increase
//--DEBUGGING-----------------------------------
SendMessageToPC(oPC, "New Appearance: " + IntToString(iNewApp));
       iNewApp++;
       //-- check we didnt hit the end
       s2DA_ACBonus = GetCachedACBonus(s2DAFile, iNewApp);
       if (s2DA_ACBonus == "FAIL")
       {//-- if so, loop back to 1
          iNewApp = 1;
       }
     }
  }

  if(iToModify == ITEM_APPR_ARMOR_MODEL_ROBE)
  {//-- check for valid part
     while(RobeIsInvalid(iNewApp, nGender))
     {//-- increase
       iNewApp++;
       //-- check we didnt hit the end
       s2DA_ACBonus = GetCachedACBonus(s2DAFile, iNewApp);
       if (s2DA_ACBonus == "FAIL")
       {//-- if so, loop back to 1
          iNewApp = 1;
       }
     }
  }

//--END restriction list verification section ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify, iNewApp, TRUE);

    DestroyObject(oItem);
    SendMessageToPC(oPC, "New Appearance: " + IntToString(iNewApp));

    AssignCommand(OBJECT_SELF, ActionEquipItem(oNewItem, INVENTORY_SLOT_CHEST));

    ResetConversationInput(oPC);
}




string GetCachedACBonus(string sFile, int iRow) {
    string sACBonus = GetLocalString(GetModule(), sFile + IntToString(iRow));

    if (sACBonus == "") {
        sACBonus = Get2DAString(sFile, "ACBONUS", iRow);

        if (sACBonus == "") {
            sACBonus = "SKIP";

            string sCost = Get2DAString(sFile, "COSTMODIFIER", iRow);
            if (sCost == "" ) sACBonus = "FAIL";
        }

        SetLocalString(GetModule(), sFile + IntToString(iRow), sACBonus);
    }

    return sACBonus;
}
