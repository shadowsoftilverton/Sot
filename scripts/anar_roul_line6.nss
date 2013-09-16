///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine6 = GetLocalInt(OBJECT_SELF,"iLine6");

ixLine6 += iBet;
SetLocalInt(OBJECT_SELF,"iLine6", ixLine6);

}
