///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet9 = GetLocalInt(OBJECT_SELF,"iStreet9");

ixStreet9 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet9", ixStreet9);

}
