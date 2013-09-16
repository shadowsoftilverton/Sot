///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixDoz3 = GetLocalInt(OBJECT_SELF,"iDoz3");

ixDoz3 += iBet;
SetLocalInt(OBJECT_SELF,"iDoz3", ixDoz3);

}
