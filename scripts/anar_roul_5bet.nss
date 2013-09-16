///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix5su = GetLocalInt(OBJECT_SELF,"i5su");

ix5su += iBet;
SetLocalInt(OBJECT_SELF,"i5su", ix5su);

}
