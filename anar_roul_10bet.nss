///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix10su = GetLocalInt(OBJECT_SELF,"i10su");

ix10su += iBet;
SetLocalInt(OBJECT_SELF,"i10su", ix10su);

}
