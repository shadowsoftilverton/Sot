/*
Monster Slots
By Ray Miller
kaynekayne@bigfoot.com
*/
#include "smach_configure"

object oPC = GetPCSpeaker();

//This little wrapper function is because DelayCommand
//must be used with void returning functions.
void SpinReel(int iReel, string sReel, location lReel)
{
effect eStopReel = EffectVisualEffect(iReelStopEffect);
object oReel = GetLocalObject(OBJECT_SELF, "oReel" + IntToString(iReel));
if(GetIsObjectValid(oReel)) DestroyObject(oReel);
object oCreature = CreateObject(SymbolType, sReel, lReel);
SetLocalObject(OBJECT_SELF, "oReel" + IntToString(iReel), oCreature);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStopReel, oCreature, 1.0);
}

// Again, a wrapper function to accomidate DelayCommand.
void ApplyWinEffects()
{
effect eWin = EffectVisualEffect(iReelWinEffect);
object oReel1 = GetLocalObject(OBJECT_SELF, "oReel1");
object oReel2 = GetLocalObject(OBJECT_SELF, "oReel2");
object oReel3 = GetLocalObject(OBJECT_SELF, "oReel3");
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWin, oReel1, 1.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWin, oReel2, 1.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWin, oReel3, 1.0);
FloatingTextStringOnCreature("WINNER!", oPC);
AssignCommand(oPC, PlayAnimation(iWinnerAnimation, 1.0, 1.0));
}

void main()
{
//Define variables
int bWinner, iGold;
int iBet = GetLocalInt(OBJECT_SELF, "bet" + IntToString(GetLocalInt(oPC, "smach_iCurrentBet")));

//Ensure the player has enough gold to cover the bet and take it.
if(GetGold(oPC) < iBet)
    {
    SendMessageToPC(oPC, "You don't have that much gold!");
    return;
    }

//Give time to complete last game
if(!GetLocalInt(OBJECT_SELF, "bGameComplete")) return;
DeleteLocalInt(OBJECT_SELF, "bGameComplete");

//Take the bet and Play the lever animation.  This didn't seem to work
//with me very well.  I eventually had to rip this little technique off
//of the WW1 infernal contraption.
TakeGoldFromCreature(iBet, oPC, TRUE);
PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
DelayCommand(0.5, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

//Get total reel stops from configuration.
int iTotalStops = GetLocalInt(OBJECT_SELF, "TotalStops");

//if there are symbols present from the last play, destroy them.
if(GetIsObjectValid(GetLocalObject(OBJECT_SELF, "oReel1"))) DestroyObject(GetLocalObject(OBJECT_SELF, "oReel1"));
if(GetIsObjectValid(GetLocalObject(OBJECT_SELF, "oReel2"))) DestroyObject(GetLocalObject(OBJECT_SELF, "oReel2"));
if(GetIsObjectValid(GetLocalObject(OBJECT_SELF, "oReel3"))) DestroyObject(GetLocalObject(OBJECT_SELF, "oReel3"));

//Determine the stopping place of each reel.
int iReel1 = Random(iTotalStops) + 1;
int iReel2 = Random(iTotalStops) + 1;
int iReel3 = Random(iTotalStops) + 1;

//Get the resref of each symbol.
string sReel1 = GetLocalString(OBJECT_SELF, "Reel1_" + IntToString(iReel1));
string sReel2 = GetLocalString(OBJECT_SELF, "Reel2_" + IntToString(iReel2));
string sReel3 = GetLocalString(OBJECT_SELF, "Reel3_" + IntToString(iReel3));

//Get the location to spawn each symbol.
location lReel1 = GetLocation(GetObjectByTag("REEL1_" + GetTag(OBJECT_SELF)));
location lReel2 = GetLocation(GetObjectByTag("REEL2_" + GetTag(OBJECT_SELF)));
location lReel3 = GetLocation(GetObjectByTag("REEL3_" + GetTag(OBJECT_SELF)));

//Apply the spin effect to the reel locations.
effect eSpinReel = EffectVisualEffect(iReelSpinEffect);
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSpinReel, lReel1, 1.0);
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSpinReel, lReel2, 2.0);
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSpinReel, lReel3, 3.0);

//Spawn the symbols.
DelayCommand(1.0, SpinReel(1, sReel1, lReel1));
DelayCommand(2.0, SpinReel(2, sReel2, lReel2));
DelayCommand(3.0, SpinReel(3, sReel3, lReel3));

//Check for win.
iGold = GetSlotMachineWin(sReel1, sReel2, sReel3);

//If the player is a winner, apply effects, send messages, and pay out the award.
if(iGold)
    {
    float fDelay = 4.0;
    int iWin = iBet * iGold;
    int iCounter1;
    DelayCommand(4.0, ApplyWinEffects());
    DelayCommand(4.0, SendMessageToPC(oPC, "Winner!  You win " + IntToString(iWin) + " gold!!"));
    DelayCommand(4.0, GiveGoldToCreature(oPC, iWin));
    if(iGold > 50) iGold =50;
    //play sounds of coins dropping.
    for(iCounter1 = 1; iCounter1 <= iGold; iCounter1++)
        {
        DelayCommand(fDelay, PlaySound("it_coins"));
        fDelay = fDelay + 0.2;
        }
    }

//Flag game over for next pull.
DelayCommand(4.5, SetLocalInt(OBJECT_SELF, "bGameComplete", TRUE));
}
