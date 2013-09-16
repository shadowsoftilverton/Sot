/*
Created On: 5/5/2003
by: Ray Miller
kaynekayne@bigfoot.com

This is the main configuration file for the "Monster Slots" slot machine.  The script
can be edited in many ways to change the appearance and behavior of the machine.
Things like the symbols, allowable bets, and visual effects are very simple matters to
change.  Other things, such as reel construction and par sheet are best left to those
with scripting ability and an understanding of slot machine odds.

IMPORTANT NOTE:  Remember if you change anything in this file, you must BUILD your
module.  I can not stress this enough.  If you change ANYTHING in this file you MUST
do a BUILD on your module.
*/

////////////////////////////////////////////////////////////////////////////////////////////////
//                              SYMBOLS
////////////////////////////////////////////////////////////////////////////////////////////////

//You can use anything you like for the slot machine symbols.  If you want to use
//placeables instead of creatures, change the following to OBJECT_TYPE_PLACEABLE.
//Remember that if you use your own creatures for slot machine
//symbols you MUST strip away ALL of their AI scripts.  That is unless you want
//your players to fight your slot machine.
int SymbolType = OBJECT_TYPE_CREATURE;

//To change the number of symbols you must change the NumberOfSymbols
//variable below then add or subtract the symbols from both here AND
//in the CONFIGURE REELS section below.
//Unless you are very familiar with slot machines, par sheets, and the
//mathmatics involved, I really don't recommend changing the number of
//symbols or the number of instances, as very small changes can have a
//tremendous impact on the odds.
int NumberOfSymbols = 5;

//These are the Blueprint ResRefs of the 5 slot machine symbols and the
//number of instances on each reel.

//        Symbol ResRef          |     Instances of this symbol
//---------------------------------------------------------------
string sSymbol1 = "slotgoblin";    int iSymbol1 = 9;// 9 of these
string sSymbol2 = "slotorc";       int iSymbol2 = 5;// 5 of these
string sSymbol3 = "slotminotaur";  int iSymbol3 = 4;// 4 of these
string sSymbol4 = "slotsuccubus";  int iSymbol4 = 3;// 3 of these
string sSymbol5 = "slotknight";    int iSymbol5 = 1;// 1 of these
//                                         Total: 22 stops
////////////////////////////////////////////////////////////////////////////////////////////////






////////////////////////////////////////////////////////////////////////////////////////////////
//                                 EFFECTS
////////////////////////////////////////////////////////////////////////////////////////////////
// Here you can change the effects used by the slot machine.
int iReelSpinEffect = VFX_IMP_LIGHTNING_S; //This effect happens at the location of each reel when the handle is pulled.
int iReelStopEffect = VFX_DUR_GHOSTLY_VISAGE; //This effect happens at the location of each reel when the symbol appears.
int iReelWinEffect = VFX_IMP_LIGHTNING_M; //This effect is applied briefly to the reel symbols on a win.
int iWinnerAnimation = ANIMATION_FIREFORGET_VICTORY1;//The animation the PC plays when he/she wins.
////////////////////////////////////////////////////////////////////////////////////////////////






void ConfigureSlotMachine()
{
SetLocalInt(OBJECT_SELF, "bGameComplete", TRUE);
int iCounter1, iCounter2, iPosition;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           PAR SHEET
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//The following is the PAR sheet for the slot machine.  This is where you can customize the payouts for the
//different winning combos.  If this doesn't make sense to you, it is advisable not to tweek it because very small
//adjustments in payouts can cause the machine percentage to go over 100, at which time you will be giving your
//players money.
//
//Here, you can only change the values that these combinations pay.  To actually add, change, or remove winning
//combinations it is necessary to make adjustments to the TEST FOR WIN section below, where the results of the
//spin are tested.
SetLocalInt(OBJECT_SELF, "WinningCombinations", 7);
//                                                                                          Possible
//                                          Symbol #     |   Symbol #     |   Symbol #    |  Combos  |  Award  | Payout
//                                          ---------------------------------------------------------------------------
SetLocalInt(OBJECT_SELF, "Combo1", 1);    //Symbol 2(5)  X  !Symbol 2(17) X     Any(22)   =   1870   X      1     1870
SetLocalInt(OBJECT_SELF, "Combo2", 2);    //Symbol 1(9)  X   Symbol 1(9)  X   Symbol 1(9) =   1458   X      2     1458
SetLocalInt(OBJECT_SELF, "Combo3", 4);    //Symbol 2(5)  X   Symbol 2(5)  X  !Symbol 2(17)=    425   X      4     1700
SetLocalInt(OBJECT_SELF, "Combo4", 10);   //Symbol 2(5)  X   Symbol 2(5)  X   Symbol 2(5) =    125   X     10     1250
SetLocalInt(OBJECT_SELF, "Combo5", 20);   //Symbol 3(4)  X   Symbol 3(4)  X   Symbol 3(4) =     64   X     20     1280
SetLocalInt(OBJECT_SELF, "Combo6", 50);   //Symbol 4(3)  X   Symbol 4(3)  X   Symbol 4(3) =     27   X     50     1350
SetLocalInt(OBJECT_SELF, "Combo7", 1000); //Symbol 5(1)  X   Symbol 5(1)  X   Symbol 5(1) =      1   X   1000     1000
//                                          ---------------------------------------------------------------------------
//                                                                                                 Total Payout:  9908
//                                                                                                 Total Combos: 10648
//                                                                                                   Percentage: 93.05
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






////////////////////////////////////////////////////////////////////////////////////////////////
//                                        PAY TABLE
////////////////////////////////////////////////////////////////////////////////////////////////
//This is displayed to the player in the conversation file if he/she requests to see the pay table.
//The number of pays is determined by the WinningCombinations variable in the PAR sheet above.
SetLocalString(OBJECT_SELF, "Pay1", "ORC --- ---");
SetLocalString(OBJECT_SELF, "Pay2", "GOBLIN GOBLIN GOBLIN");
SetLocalString(OBJECT_SELF, "Pay3", "ORC ORC ---");
SetLocalString(OBJECT_SELF, "Pay4", "ORC ORC ORC");
SetLocalString(OBJECT_SELF, "Pay5", "MINOTAUR MINOTAUR MINOTAUR");
SetLocalString(OBJECT_SELF, "Pay6", "SUCCUBUS SUCCUBUS SUCCUBUS");
SetLocalString(OBJECT_SELF, "Pay7", "KNIGHT KNIGHT KNIGHT");
//--------------------------------Do not edit below this line------------------------------------
string sPayTable;
int iPay;
for(iCounter1 = 1; iCounter1 <= GetLocalInt(OBJECT_SELF, "WinningCombinations"); iCounter1++)
    {
    iPay = GetLocalInt(OBJECT_SELF, "Combo" + IntToString(iCounter1));
    sPayTable = sPayTable + IntToString(iPay) + "X - ";
    //for(iCounter2 = 1; iCounter2 <= 9 - GetStringLength(IntToString(iPay)); iCounter2++)
    //    {
    //    sPayTable = sPayTable + " ";
    //    }
    sPayTable = sPayTable + GetLocalString(OBJECT_SELF, "Pay" + IntToString(iCounter1)) + "\n";
    }
SetLocalString(OBJECT_SELF, "PayTable", sPayTable);
SetCustomToken(101, sPayTable);
////////////////////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////////////////////
//                                       ALLOWABLE BETS
////////////////////////////////////////////////////////////////////////////////////////////////
//To change this, simply change the NumberOfBets variable and add, take away, or adjust the other
//variables.
SetLocalInt(OBJECT_SELF, "NumberOfBets", 9);
SetLocalInt(OBJECT_SELF, "bet1", 1);
SetLocalInt(OBJECT_SELF, "bet2", 5);
SetLocalInt(OBJECT_SELF, "bet3", 25);
SetLocalInt(OBJECT_SELF, "bet4", 50);
SetLocalInt(OBJECT_SELF, "bet5", 100);
SetLocalInt(OBJECT_SELF, "bet6", 500);
SetLocalInt(OBJECT_SELF, "bet7", 1000);
SetLocalInt(OBJECT_SELF, "bet8", 2500);
SetLocalInt(OBJECT_SELF, "bet9", 10000);
////////////////////////////////////////////////////////////////////////////////////////////////






/////////////////////////////////////////////////////////////////////////////////////////////////
//                                        CONFIGURE REELS
/////////////////////////////////////////////////////////////////////////////////////////////////
//                    These should correspond with the Symbols defined above.
SetLocalString(OBJECT_SELF, "sSymbol1", sSymbol1); SetLocalInt(OBJECT_SELF, "iSymbol1", iSymbol1);
SetLocalString(OBJECT_SELF, "sSymbol2", sSymbol2); SetLocalInt(OBJECT_SELF, "iSymbol2", iSymbol2);
SetLocalString(OBJECT_SELF, "sSymbol3", sSymbol3); SetLocalInt(OBJECT_SELF, "iSymbol3", iSymbol3);
SetLocalString(OBJECT_SELF, "sSymbol4", sSymbol4); SetLocalInt(OBJECT_SELF, "iSymbol4", iSymbol4);
SetLocalString(OBJECT_SELF, "sSymbol5", sSymbol5); SetLocalInt(OBJECT_SELF, "iSymbol5", iSymbol5);
//          -------------------------Do not edit below this line-------------------------------

for(iCounter1 = 1; iCounter1 <= NumberOfSymbols; iCounter1++)
    {
    for(iCounter2 = 1; iCounter2 <= GetLocalInt(OBJECT_SELF, "iSymbol" + IntToString(iCounter1)); iCounter2++)
        {
        iPosition = iPosition + 1;
        SetLocalString(OBJECT_SELF, "Reel1_" + IntToString(iPosition), GetLocalString(OBJECT_SELF, "sSymbol" + IntToString(iCounter1)));
        SetLocalString(OBJECT_SELF, "Reel2_" + IntToString(iPosition), GetLocalString(OBJECT_SELF, "sSymbol" + IntToString(iCounter1)));
        SetLocalString(OBJECT_SELF, "Reel3_" + IntToString(iPosition), GetLocalString(OBJECT_SELF, "sSymbol" + IntToString(iCounter1)));
        }
    }
SetLocalInt(OBJECT_SELF, "TotalStops", iPosition);
/////////////////////////////////////////////////////////////////////////////////////////////////
}



/////////////////////////////////////////////////////////////////////////////////////////////////
//                                   TEST FOR WINS
/////////////////////////////////////////////////////////////////////////////////////////////////
//This is for advanced scripters who want to use my script basically as a "template".
//If you want to set up additional winning combonations, the only thing that needs to
//be edited here is the if statements along with adding additional case statements for
//additional combinations.  Note that the number of combinations is defined by the
//"WinningCombinations" variable in the PAR sheet, so the number of case statements should
//match that.
int GetSlotMachineWin(string sReel1, string sReel2, string sReel3)
{
int iCounter1;
int bWin;
int iGold;
for(iCounter1 = 1; iCounter1 <= GetLocalInt(OBJECT_SELF, "WinningCombinations"); iCounter1++)
    {
    switch(iCounter1)
        {



        case 1: if(sReel1 == sSymbol2
                && sReel2 !=sSymbol2)
        bWin = TRUE;
      break;

        case 2: if(sReel1 == sSymbol1
                && sReel2 == sSymbol1
                && sReel3 == sSymbol1)
        bWin = TRUE;
      break;

        case 3: if(sReel1 == sSymbol2
                && sReel2 == sSymbol2
                && sReel3 != sSymbol2)
        bWin = TRUE;
      break;

        case 4: if(sReel1 == sSymbol2
                && sReel2 == sSymbol2
                && sReel3 == sSymbol2)
        bWin = TRUE;
      break;

        case 5: if(sReel1 == sSymbol3
                && sReel2 == sSymbol3
                && sReel3 == sSymbol3)
        bWin = TRUE;
      break;

        case 6: if(sReel1 == sSymbol4
                && sReel2 == sSymbol4
                && sReel3 == sSymbol4)
        bWin = TRUE;
      break;

        case 7: if(sReel1 == sSymbol5
                && sReel2 == sSymbol5
                && sReel3 == sSymbol5)
        bWin = TRUE;
      break;




        default: bWin = FALSE;
      break;
        }
    if(bWin)
        {
        iGold = GetLocalInt(OBJECT_SELF, "Combo" + IntToString(iCounter1));
        break;
        }
    }
return iGold;
}
////////////////////////////////////////////////////////////////////////////////////////////////
