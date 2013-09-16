//::///////////////////////////////////////////////
//:: Tailoring - Buy Cost Helm
//:: tlr_buycosthelm.nss
//:://////////////////////////////////////////////
/*
   Sets the cost to buy the helmet on the model.
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
int StartingConditional()
{
    int BaseCost = 0; //-- change to raise prices
    float BaseMultiplyer = 2.0; //-- milamber's default


    object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, OBJECT_SELF);
    int iModifier=GetLocalInt(OBJECT_SELF, "Helm_Mod_Buy");
    int iValue=GetLocalInt(OBJECT_SELF, "Helm_Value_Buy");

    int iCost = BaseCost + FloatToInt((IntToFloat(GetGoldPieceValue(oItem)) * BaseMultiplyer));


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

    SetCustomToken(9877, sOut);
    //-- this is called to check if the pc has the money to buy
    SetLocalInt(OBJECT_SELF, "CURRENTPRICE", iCost);

    return TRUE;
}
