///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix15su = GetLocalInt(OBJECT_SELF,"i15su");

ix15su += iBet;
SetLocalInt(OBJECT_SELF,"i15su", ix15su);

}
