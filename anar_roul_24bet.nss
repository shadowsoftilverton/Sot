///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix24su = GetLocalInt(OBJECT_SELF,"i24su");

ix24su += iBet;
SetLocalInt(OBJECT_SELF,"i24su", ix24su);

}
