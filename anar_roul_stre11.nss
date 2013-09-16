///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet11 = GetLocalInt(OBJECT_SELF,"iStreet11");

ixStreet11 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet11", ixStreet11);

}
