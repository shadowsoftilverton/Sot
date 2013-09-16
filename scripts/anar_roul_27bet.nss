///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix27su = GetLocalInt(OBJECT_SELF,"i27su");

ix27su += iBet;
SetLocalInt(OBJECT_SELF,"i27su", ix27su);

}
