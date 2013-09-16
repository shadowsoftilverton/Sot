///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix13su = GetLocalInt(OBJECT_SELF,"i13su");

ix13su += iBet;
SetLocalInt(OBJECT_SELF,"i13su", ix13su);

}
