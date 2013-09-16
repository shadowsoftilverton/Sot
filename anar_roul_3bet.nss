///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix3su = GetLocalInt(OBJECT_SELF,"i3su");

ix3su += iBet;
SetLocalInt(OBJECT_SELF,"i3su", ix3su);

}
