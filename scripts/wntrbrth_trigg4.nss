void main()
{

object oPC = GetEnteringObject();

if(!GetIsPC(oPC)) return;

SendMessageToPC(oPC, "The wall before you appears to be made of ice. There are indentions going up it - someone has been this way before, and carved hand and foot holds into it. They appear worn, however, and are likely quite old...");

}
