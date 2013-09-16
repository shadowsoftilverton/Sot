///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixCol1 = GetLocalInt(OBJECT_SELF,"iCol1");

ixCol1 += iBet;
SetLocalInt(OBJECT_SELF,"iCol1", ixCol1);

}
