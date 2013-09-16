//::///////////////////////////////////////////////
//:: Tailoring - Copy Cost Weapon
//:: tlr_copycostshld.nss
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int BaseCost = 0; //-- change this to raise your base prices.
    float BaseDivider = 0.2; //-- mil default

    object oNPCItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
    object oPCItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    /*int iCost = FloatToInt(IntToFloat(GetGoldPieceValue(oPCItem)) * 0.2f);

    int iModifier=GetLocalInt(OBJECT_SELF, "Shield_Mod_Copy");
    int iValue=GetLocalInt(OBJECT_SELF, "Shield_Value_Copy");

    switch (iModifier)
    {
       case 0: //Variable-set price modifying is OFF
           iCost = BaseCost + GetGoldPieceValue(oNPCItem) + FloatToInt(IntToFloat(GetGoldPieceValue(oPCItem)) * BaseDivider);
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

           else iCost = BaseCost + GetGoldPieceValue(oNPCItem) + FloatToInt(IntToFloat(GetGoldPieceValue(oPCItem)) * BaseDivider);
           break;

      case 5: //Variable "Value" will be used to SET the price
           iCost = iValue;
           break;

    } */

    string sOut = "Do you wish to continue with the copy?\n";
    SetCustomToken(9879, sOut);
    //-- this is called to check if the pc has the money to buy
    //SetLocalInt(OBJECT_SELF, "CURRENTPRICE", iCost);

    return TRUE;
}
