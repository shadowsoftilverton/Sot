///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int ix33su = GetLocalInt(OBJECT_SELF,"i33su");

ix33su += iBet;
SetLocalInt(OBJECT_SELF,"i33su", ix33su);

}
