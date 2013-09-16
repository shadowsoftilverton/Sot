///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet5 = GetLocalInt(OBJECT_SELF,"iStreet5");

ixStreet5 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet5", ixStreet5);

}
