///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix22su = GetLocalInt(OBJECT_SELF,"i22su");

ix22su += iBet;
SetLocalInt(OBJECT_SELF,"i22su", ix22su);

}
