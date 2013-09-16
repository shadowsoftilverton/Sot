///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine10 = GetLocalInt(OBJECT_SELF,"iLine10");

ixLine10 += iBet;
SetLocalInt(OBJECT_SELF,"iLine10", ixLine10);

}
