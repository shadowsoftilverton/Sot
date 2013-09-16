///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine11 = GetLocalInt(OBJECT_SELF,"iLine11");

ixLine11 += iBet;
SetLocalInt(OBJECT_SELF,"iLine11", ixLine11);

}
