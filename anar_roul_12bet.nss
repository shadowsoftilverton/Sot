///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix12su = GetLocalInt(OBJECT_SELF,"i12su");

ix12su += iBet;
SetLocalInt(OBJECT_SELF,"i12su", ix12su);

}
