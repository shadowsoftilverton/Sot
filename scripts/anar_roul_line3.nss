///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine3 = GetLocalInt(OBJECT_SELF,"iLine3");

ixLine3 += iBet;
SetLocalInt(OBJECT_SELF,"iLine3", ixLine3);

}
