///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ixEven = GetLocalInt(OBJECT_SELF,"iEven");

ixEven += iBet;
SetLocalInt(OBJECT_SELF,"iEven", ixEven);

}
