void main()
{

object oPC = GetEnteringObject();

if(!GetIsPC(oPC)) return;

SendMessageToPC(oPC, "The mist is becoming cooler now, and the temperature steadily drops the further into the mountain you delve.");

}
