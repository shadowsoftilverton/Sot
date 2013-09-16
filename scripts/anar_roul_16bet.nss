///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix16su = GetLocalInt(OBJECT_SELF,"i16su");

ix16su += iBet;
SetLocalInt(OBJECT_SELF,"i16su", ix16su);

}
