///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet1 = GetLocalInt(OBJECT_SELF,"iStreet1");

ixStreet1 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet1", ixStreet1);

}
