///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix14su = GetLocalInt(OBJECT_SELF,"i14su");

ix14su += iBet;
SetLocalInt(OBJECT_SELF,"i14su", ix14su);

}
