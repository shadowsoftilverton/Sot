///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixLine7 = GetLocalInt(OBJECT_SELF,"iLine7");

ixLine7 += iBet;
SetLocalInt(OBJECT_SELF,"iLine7", ixLine7);

}
