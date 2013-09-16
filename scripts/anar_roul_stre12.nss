///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixStreet12 = GetLocalInt(OBJECT_SELF,"iStreet12");

ixStreet12 += iBet;
SetLocalInt(OBJECT_SELF,"iStreet12", ixStreet12);

}
