///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet8 = GetLocalInt(OBJECT_SELF,"iStreet8");

ixStreet8 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet8", ixStreet8);

}
