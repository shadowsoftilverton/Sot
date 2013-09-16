///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixHigh = GetLocalInt(OBJECT_SELF,"iHigh");

ixHigh += iBet;
SetLocalInt(OBJECT_SELF,"iHigh", ixHigh);

}
