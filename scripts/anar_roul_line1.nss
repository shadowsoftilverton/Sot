///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine1 = GetLocalInt(OBJECT_SELF,"iLine1");

ixLine1 += iBet;
SetLocalInt(OBJECT_SELF,"iLine1", ixLine1);

}
