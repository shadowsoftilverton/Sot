///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix29su = GetLocalInt(OBJECT_SELF,"i29su");

ix29su += iBet;
SetLocalInt(OBJECT_SELF,"i29su", ix29su);

}
