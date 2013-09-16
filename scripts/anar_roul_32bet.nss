///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix32su = GetLocalInt(OBJECT_SELF,"i32su");

ix32su += iBet;
SetLocalInt(OBJECT_SELF,"i32su", ix32su);

}
