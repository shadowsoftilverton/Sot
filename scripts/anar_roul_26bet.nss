///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix26su = GetLocalInt(OBJECT_SELF,"i26su");

ix26su += iBet;
SetLocalInt(OBJECT_SELF,"i26su", ix26su);

}
