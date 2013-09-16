///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix9su = GetLocalInt(OBJECT_SELF,"i9su");

ix9su += iBet;
SetLocalInt(OBJECT_SELF,"i9su", ix9su);

}
