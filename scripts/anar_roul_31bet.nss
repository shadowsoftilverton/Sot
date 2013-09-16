///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix31su = GetLocalInt(OBJECT_SELF,"i31su");

ix31su += iBet;
SetLocalInt(OBJECT_SELF,"i31su", ix31su);

}
