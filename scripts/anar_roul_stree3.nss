///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet3 = GetLocalInt(OBJECT_SELF,"iStreet3");

ixStreet3 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet3", ixStreet3);

}
