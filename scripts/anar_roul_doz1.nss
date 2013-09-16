///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixDoz1 = GetLocalInt(OBJECT_SELF,"iDoz1");

ixDoz1 += iBet;
SetLocalInt(OBJECT_SELF,"iDoz1", ixDoz1);

}
