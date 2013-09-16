///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine2 = GetLocalInt(OBJECT_SELF,"iLine2");

ixLine2 += iBet;
SetLocalInt(OBJECT_SELF,"iLine2", ixLine2);

}
