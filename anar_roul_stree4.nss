///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet4 = GetLocalInt(OBJECT_SELF,"iStreet4");

ixStreet4 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet4", ixStreet4);

}
