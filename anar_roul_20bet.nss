///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix20su = GetLocalInt(OBJECT_SELF,"i20su");

ix20su += iBet;
SetLocalInt(OBJECT_SELF,"i20su", ix20su);

}
