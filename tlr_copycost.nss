//::///////////////////////////////////////////////
//:: Tailoring - Copy Cost
//:: tlr_copycost.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 9, 2004
//-- bloodsong:  added base cost for adjusting price ranges.
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int BaseCost = 0; //-- change this to raise your base prices.
    float BaseDivider = 0.2; //-- mil default

    object oNPCItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);
    object oPCItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);

    /*int iModifier=GetLocalInt(OBJECT_SELF, "Cloth_Mod_Copy");
    int iValue=GetLocalInt(OBJECT_SELF, "Cloth_Value_Copy");
    int iCost = BaseCost + GetGoldPieceValue(oNPCItem) + FloatToInt(IntToFloat(GetGoldPieceValue(oPCItem)) * BaseDivider);


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

    }*/

    int iAC = GetItemACValue(oNPCItem);

    string sOut = "AC: " + IntToString(iAC) + "\n";
    sOut += "(Note: You may only copy appearances that have the same AC value as your current clothing.)\n";
    sOut += "\nDo you wish to continue with the copy?";

    SetCustomToken(9876, sOut);
    //-- this is called to check if the pc has the money to buy
    //SetLocalInt(OBJECT_SELF, "CURRENTPRICE", iCost);

    return TRUE;
}
