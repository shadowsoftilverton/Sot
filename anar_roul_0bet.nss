///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix0su = GetLocalInt(OBJECT_SELF,"i0su");

ix0su += iBet;
SetLocalInt(OBJECT_SELF,"i0su", ix0su);

}
