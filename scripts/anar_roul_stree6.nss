///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet6 = GetLocalInt(OBJECT_SELF,"iStreet6");

ixStreet6 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet6", ixStreet6);

}
