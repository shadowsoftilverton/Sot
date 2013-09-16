///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixCol3 = GetLocalInt(OBJECT_SELF,"iCol3");

ixCol3 += iBet;
SetLocalInt(OBJECT_SELF,"iCol3", ixCol3);

}
