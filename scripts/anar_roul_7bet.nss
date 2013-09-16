///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix7su = GetLocalInt(OBJECT_SELF,"i7su");

ix7su += iBet;
SetLocalInt(OBJECT_SELF,"i7su", ix7su);

}
