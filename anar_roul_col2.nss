///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixCol2 = GetLocalInt(OBJECT_SELF,"iCol2");

ixCol2 += iBet;
SetLocalInt(OBJECT_SELF,"iCol2", ixCol2);

}
