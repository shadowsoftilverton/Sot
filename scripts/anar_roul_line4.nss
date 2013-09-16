///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine4 = GetLocalInt(OBJECT_SELF,"iLine4");

ixLine4 += iBet;
SetLocalInt(OBJECT_SELF,"iLine4", ixLine4);

}
