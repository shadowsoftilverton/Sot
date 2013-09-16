///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix23su = GetLocalInt(OBJECT_SELF,"i23su");

ix23su += iBet;
SetLocalInt(OBJECT_SELF,"i23su", ix23su);

}
