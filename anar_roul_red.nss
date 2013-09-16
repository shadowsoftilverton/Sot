///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixRed = GetLocalInt(OBJECT_SELF,"iRed");

ixRed += iBet;
SetLocalInt(OBJECT_SELF,"iRed", ixRed);

}
