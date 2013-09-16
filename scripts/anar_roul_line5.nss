///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine5 = GetLocalInt(OBJECT_SELF,"iLine5");

ixLine5 += iBet;
SetLocalInt(OBJECT_SELF,"iLine5", ixLine5);

}
