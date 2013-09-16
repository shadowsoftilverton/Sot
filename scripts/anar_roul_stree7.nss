///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet7 = GetLocalInt(OBJECT_SELF,"iStreet7");

ixStreet7 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet7", ixStreet7);

}
