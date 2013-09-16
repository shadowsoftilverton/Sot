///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixDoz2 = GetLocalInt(OBJECT_SELF,"iDoz2");

ixDoz2 += iBet;
SetLocalInt(OBJECT_SELF,"iDoz2", ixDoz2);

}
