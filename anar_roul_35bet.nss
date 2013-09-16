///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix35su = GetLocalInt(OBJECT_SELF,"i35su");

ix35su += iBet;
SetLocalInt(OBJECT_SELF,"i35su", ix35su);

}
