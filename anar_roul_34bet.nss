///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix34su = GetLocalInt(OBJECT_SELF,"i34su");

ix34su += iBet;
SetLocalInt(OBJECT_SELF,"i34su", ix34su);

}
