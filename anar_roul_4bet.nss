///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix4su = GetLocalInt(OBJECT_SELF,"i4su");

ix4su += iBet;
SetLocalInt(OBJECT_SELF,"i4su", ix4su);

}
