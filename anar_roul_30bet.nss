///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix30su = GetLocalInt(OBJECT_SELF,"i30su");

ix30su += iBet;
SetLocalInt(OBJECT_SELF,"i30su", ix30su);

}
