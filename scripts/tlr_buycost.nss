//::///////////////////////////////////////////////
//:: Tailoring - Buy Cost
//:: tlr_buycost.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 8, 2004
//-- bloodsong base cost and xer for adjusting price ranges
//:://////////////////////////////////////////////
int StartingConditional()
{
    int BaseCost = 0; //-- change to raise prices
    float BaseMultiplyer = 2.0; //-- milamber's default


    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);
    int iCost = BaseCost + FloatToInt((IntToFloat(GetGoldPieceValue(oItem)) * BaseMultiplyer));

    int iAC = GetItemACValue(oItem);

    int iModifier=GetLocalInt(OBJECT_SELF, "Cloth_Mod_Buy");
    int iValue=GetLocalInt(OBJECT_SELF, "Cloth_Value_Buy");


    switch (iModifier)
    {
       case 0: //Variable-set price modifying is OFF
           iCost = BaseCost + FloatToInt((IntToFloat(GetGoldPieceValue(oItem)) * BaseMultiplyer));
           break;

       case 1: //Variable "Value" will be used to ADD to the price
           iCost = iCost+iValue;
           break;

       case 2: //Variable "Value" will be used to SUBTRACT from the price
           iCost = iCost-iValue;
           break;

       case 3: //Variable "Value" will be used to MULTIPLY by the price
           iCost = iCost*iValue;
           break;

       case 4: //Variable "Value" will be used to DIVIDE by the price
           if (iValue!=0)
              iCost = iCost/iValue;

           else iCost = BaseCost + FloatToInt((IntToFloat(GetGoldPieceValue(oItem)) * BaseMultiplyer));
           break;

      case 5: //Variable "Value" will be used to SET the price
           iCost = iValue;
           break;

    }

    string sOut = "Cost: " + IntToString(iCost) + " gold.\n";
    sOut += "AC: " + IntToString(iAC) + "\n";
    sOut += "(Note: Armor feats my be required to wear this.)\n";
    sOut += "\nDo you wish to continue with the purchase?";

    SetCustomToken(9876, sOut);
    //-- this is called to check if the pc has the money to buy
    SetLocalInt(OBJECT_SELF, "CURRENTPRICE", iCost);

    return TRUE;
}
