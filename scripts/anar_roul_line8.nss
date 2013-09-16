///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine8 = GetLocalInt(OBJECT_SELF,"iLine8");

ixLine8 += iBet;
SetLocalInt(OBJECT_SELF,"iLine8", ixLine8);

}
