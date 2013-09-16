///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix6su = GetLocalInt(OBJECT_SELF,"i6su");

ix6su += iBet;
SetLocalInt(OBJECT_SELF,"i6su", ix6su);

}
