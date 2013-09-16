///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLow = GetLocalInt(OBJECT_SELF,"iLow");

ixLow += iBet;
SetLocalInt(OBJECT_SELF,"iLow", ixLow);

}
