///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix1su = GetLocalInt(OBJECT_SELF,"i1su");

ix1su += iBet;
SetLocalInt(OBJECT_SELF,"i1su", ix1su);

}
