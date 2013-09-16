void main()
{

object oPC = GetEnteringObject();

if(!GetIsPC(oPC)) return;

SendMessageToPC(oPC, "The air is frigid, and the mist is bitingly cold. It feels like the deepest of winters, and the walls and floor are slick with ice, rather than moisture.");

}
