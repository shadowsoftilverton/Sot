///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix2su = GetLocalInt(OBJECT_SELF,"i2su");

ix2su += iBet;
SetLocalInt(OBJECT_SELF,"i2su", ix2su);

}
