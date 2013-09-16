///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix19su = GetLocalInt(OBJECT_SELF,"i19su");

ix19su += iBet;
SetLocalInt(OBJECT_SELF,"i19su", ix19su);

}
