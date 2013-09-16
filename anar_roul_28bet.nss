///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix28su = GetLocalInt(OBJECT_SELF,"i28su");

ix28su += iBet;
SetLocalInt(OBJECT_SELF,"i28su", ix28su);

}
