///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix11su = GetLocalInt(OBJECT_SELF,"i11su");

ix11su += iBet;
SetLocalInt(OBJECT_SELF,"i11su", ix11su);

}
