///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix25su = GetLocalInt(OBJECT_SELF,"i25su");

ix25su += iBet;
SetLocalInt(OBJECT_SELF,"i25su", ix25su);

}
