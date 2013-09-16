///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//
//Player's First Card
//////////////////////////////////
void main()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");

int ixCard1 = GetLocalInt(OBJECT_SELF,"iCard1");
int ixCard1n = GetLocalInt(OBJECT_SELF,"iCard1n");
string sxCard1Name = GetLocalString(OBJECT_SELF,"sCard1Name");

int ixAces = GetLocalInt(OBJECT_SELF,"iAces");
ixAces = 0;
SetLocalInt(OBJECT_SELF,"iAces",ixAces);
int ixDealersAces = GetLocalInt(OBJECT_SELF,"iDealersAces");
ixDealersAces = 0;
SetLocalInt(OBJECT_SELF,"iDealersAces",ixDealersAces);
string sxHardSoft = GetLocalString(OBJECT_SELF,"sHardSoft");


ixCard1 = Random(52)+1;
SetLocalInt(OBJECT_SELF,"iCard1", ixCard1);


//CARD NUMBER ONE CHECK

if (ixCard1 == 1 || ixCard1 == 14 || ixCard1 == 27 || ixCard1 == 40)
    {
    ixCard1n = 11;
    SetLocalInt(OBJECT_SELF,"iCard1n",ixCard1n);
    sxCard1Name = "Ace";
    SetLocalString(OBJECT_SELF,"sCard1Name","sxCard1Name");
    ixAces += 1;
    SetLocalInt(OBJECT_SELF,"iAces",ixAces);
    }
if (ixCard1 == 13 || ixCard1 == 26 || ixCard1 == 39 || ixCard1 == 52)
    {
    ixCard1n = 10;
    SetLocalInt(OBJECT_SELF,"iCard1n",ixCard1n);
    sxCard1Name = "King";
    SetLocalString(OBJECT_SELF,"sCard1Name","sxCard1Name");
    }
if (ixCard1 == 12 || ixCard1 == 25 || ixCard1 == 38 || ixCard1 == 51)
    {
    ixCard1n = 10;
    SetLocalInt(OBJECT_SELF,"iCard1n",ixCard1n);
    sxCard1Name = "Queen";
    SetLocalString(OBJECT_SELF,"sCard1Name","sxCard1Name");
    }
if (ixCard1 == 11 || ixCard1 == 24 || ixCard1 == 37 || ixCard1 == 50)
    {
    ixCard1n = 10;
    SetLocalInt(OBJECT_SELF,"iCard1n",ixCard1n);
    sxCard1Name = "Jack";
    SetLocalString(OBJECT_SELF,"sCard1Name","sxCard1Name");
    SetLocalInt(OBJECT_SELF,"iCard1n",ixCard1n);
    }
if (ixCard1 >= 2 && ixCard1 <= 10)
    {
    ixCard1n = ixCard1;
    SetLocalInt(OBJECT_SELF,"iCard1n",ixCard1n);
    sxCard1Name = IntToString(ixCard1n);
    SetLocalString(OBJECT_SELF,"sCard1Name","sxCard1Name");
    }
if (ixCard1 >= 15 && ixCard1 <= 23)
    {
    ixCard1n = ixCard1 - 13;
    SetLocalInt(OBJECT_SELF,"iCard1n",ixCard1n);
    sxCard1Name = IntToString(ixCard1n);
    SetLocalString(OBJECT_SELF,"sCard1Name","sxCard1Name");
    }
if (ixCard1 >= 28 && ixCard1 <= 36)
    {
    ixCard1n = ixCard1 - 26;
    SetLocalInt(OBJECT_SELF,"iCard1n",ixCard1n);
    sxCard1Name = IntToString(ixCard1n);
    SetLocalString(OBJECT_SELF,"sCard1Name","sxCard1Name");
    }
if (ixCard1 >= 41 && ixCard1 <= 49)
    {
    ixCard1n = ixCard1 - 39;
    SetLocalInt(OBJECT_SELF,"iCard1n",ixCard1n);
    sxCard1Name = IntToString(ixCard1n);
    SetLocalString(OBJECT_SELF,"sCard1Name","sxCard1Name");
    }

SetCustomToken(150,(sxCard1Name));

}
