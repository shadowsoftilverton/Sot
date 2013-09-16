///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix21su = GetLocalInt(OBJECT_SELF,"i21su");

ix21su += iBet;
SetLocalInt(OBJECT_SELF,"i21su", ix21su);

}
