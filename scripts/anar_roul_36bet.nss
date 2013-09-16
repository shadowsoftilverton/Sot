///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix36su = GetLocalInt(OBJECT_SELF,"i36su");

ix36su += iBet;
SetLocalInt(OBJECT_SELF,"i36su", ix36su);

}
