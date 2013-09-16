///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixOdd = GetLocalInt(OBJECT_SELF,"iOdd");

ixOdd += iBet;
SetLocalInt(OBJECT_SELF,"iOdd", ixOdd);

}
