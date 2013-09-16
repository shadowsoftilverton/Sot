///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix18su = GetLocalInt(OBJECT_SELF,"i18su");

ix18su += iBet;
SetLocalInt(OBJECT_SELF,"i18su", ix18su);

}
