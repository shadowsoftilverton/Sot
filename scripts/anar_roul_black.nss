///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixBlack = GetLocalInt(OBJECT_SELF,"iBlack");

ixBlack += iBet;
SetLocalInt(OBJECT_SELF,"iBlack", ixBlack);

}
