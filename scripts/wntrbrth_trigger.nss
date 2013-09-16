void main()
{

object oPC = GetEnteringObject();

if(!GetIsPC(oPC)) return;

SendMessageToPC(oPC, "As you continue deeper into the mountain, you notice a steady slope to the floor. The walls are slick with moisture, and the air is thick with mist.");

}
