///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine9 = GetLocalInt(OBJECT_SELF,"iLine9");

ixLine9 += iBet;
SetLocalInt(OBJECT_SELF,"iLine9", ixLine9);

}
