///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix17su = GetLocalInt(OBJECT_SELF,"i17su");

ix17su += iBet;
SetLocalInt(OBJECT_SELF,"i17su", ix17su);

}
