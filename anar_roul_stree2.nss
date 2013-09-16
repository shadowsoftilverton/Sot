///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet2 = GetLocalInt(OBJECT_SELF,"iStreet2");

ixStreet2 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet2", ixStreet2);

}
