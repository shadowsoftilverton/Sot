///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet10 = GetLocalInt(OBJECT_SELF,"iStreet10");

ixStreet10 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet10", ixStreet10);

}
