///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix8su = GetLocalInt(OBJECT_SELF,"i8su");

ix8su += iBet;
SetLocalInt(OBJECT_SELF,"i8su", ix8su);

}
