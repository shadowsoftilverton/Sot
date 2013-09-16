///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////
void main()
{
int ixWinnings = GetLocalInt(OBJECT_SELF,"iWinnings");

int ixRed = GetLocalInt(OBJECT_SELF,"iRed");
int ixBlack = GetLocalInt(OBJECT_SELF,"iBlack");
int ixHigh = GetLocalInt(OBJECT_SELF,"iHigh");
int ixLow = GetLocalInt(OBJECT_SELF,"iLow");
int ixEven = GetLocalInt(OBJECT_SELF,"iEven");
int ixOdd = GetLocalInt(OBJECT_SELF,"iOdd");
int ixDoz1 = GetLocalInt(OBJECT_SELF,"iDoz1");
int ixDoz2 = GetLocalInt(OBJECT_SELF,"iDoz2");
int ixDoz3 = GetLocalInt(OBJECT_SELF,"iDoz3");
int ixCol1 = GetLocalInt(OBJECT_SELF,"iCol1");
int ixCol2 = GetLocalInt(OBJECT_SELF,"iCol2");
int ixCol3 = GetLocalInt(OBJECT_SELF,"iCol3");
int ix0su = GetLocalInt(OBJECT_SELF,"i0su");
int ix1su = GetLocalInt(OBJECT_SELF,"i1su");
int ix2su = GetLocalInt(OBJECT_SELF,"i2su");
int ix3su = GetLocalInt(OBJECT_SELF,"i3su");
int ix4su = GetLocalInt(OBJECT_SELF,"i4su");
int ix5su = GetLocalInt(OBJECT_SELF,"i5su");
int ix6su = GetLocalInt(OBJECT_SELF,"i6su");
int ix7su = GetLocalInt(OBJECT_SELF,"i7su");
int ix8su = GetLocalInt(OBJECT_SELF,"i8su");
int ix9su = GetLocalInt(OBJECT_SELF,"i9su");
int ix10su = GetLocalInt(OBJECT_SELF,"i10su");
int ix11su = GetLocalInt(OBJECT_SELF,"i11su");
int ix12su = GetLocalInt(OBJECT_SELF,"i12su");
int ix13su = GetLocalInt(OBJECT_SELF,"i13su");
int ix14su = GetLocalInt(OBJECT_SELF,"i14su");
int ix15su = GetLocalInt(OBJECT_SELF,"i15su");
int ix16su = GetLocalInt(OBJECT_SELF,"i16su");
int ix17su = GetLocalInt(OBJECT_SELF,"i17su");
int ix18su = GetLocalInt(OBJECT_SELF,"i18su");
int ix19su = GetLocalInt(OBJECT_SELF,"i19su");
int ix20su = GetLocalInt(OBJECT_SELF,"i20su");
int ix21su = GetLocalInt(OBJECT_SELF,"i21su");
int ix22su = GetLocalInt(OBJECT_SELF,"i22su");
int ix23su = GetLocalInt(OBJECT_SELF,"i23su");
int ix24su = GetLocalInt(OBJECT_SELF,"i24su");
int ix25su = GetLocalInt(OBJECT_SELF,"i25su");
int ix26su = GetLocalInt(OBJECT_SELF,"i26su");
int ix27su = GetLocalInt(OBJECT_SELF,"i27su");
int ix28su = GetLocalInt(OBJECT_SELF,"i28su");
int ix29su = GetLocalInt(OBJECT_SELF,"i29su");
int ix30su = GetLocalInt(OBJECT_SELF,"i30su");
int ix31su = GetLocalInt(OBJECT_SELF,"i31su");
int ix32su = GetLocalInt(OBJECT_SELF,"i32su");
int ix33su = GetLocalInt(OBJECT_SELF,"i33su");
int ix34su = GetLocalInt(OBJECT_SELF,"i34su");
int ix35su = GetLocalInt(OBJECT_SELF,"i35su");
int ix36su = GetLocalInt(OBJECT_SELF,"i36su");
int ixLine1 = GetLocalInt(OBJECT_SELF,"iLine1");
int ixLine2 = GetLocalInt(OBJECT_SELF,"iLine2");
int ixLine3 = GetLocalInt(OBJECT_SELF,"iLine3");
int ixLine4 = GetLocalInt(OBJECT_SELF,"iLine4");
int ixLine5 = GetLocalInt(OBJECT_SELF,"iLine5");
int ixLine6 = GetLocalInt(OBJECT_SELF,"iLine6");
int ixLine7 = GetLocalInt(OBJECT_SELF,"iLine7");
int ixLine8 = GetLocalInt(OBJECT_SELF,"iLine8");
int ixLine9 = GetLocalInt(OBJECT_SELF,"iLine9");
int ixLine10 = GetLocalInt(OBJECT_SELF,"iLine10");
int ixLine11 = GetLocalInt(OBJECT_SELF,"iLine11");
int ixStreet1 = GetLocalInt(OBJECT_SELF,"iStreet1");
int ixStreet2 = GetLocalInt(OBJECT_SELF,"iStreet2");
int ixStreet3 = GetLocalInt(OBJECT_SELF,"iStreet3");
int ixStreet4 = GetLocalInt(OBJECT_SELF,"iStreet4");
int ixStreet5 = GetLocalInt(OBJECT_SELF,"iStreet5");
int ixStreet6 = GetLocalInt(OBJECT_SELF,"iStreet6");
int ixStreet7 = GetLocalInt(OBJECT_SELF,"iStreet7");
int ixStreet8 = GetLocalInt(OBJECT_SELF,"iStreet8");
int ixStreet9 = GetLocalInt(OBJECT_SELF,"iStreet9");
int ixStreet10 = GetLocalInt(OBJECT_SELF,"iStreet10");
int ixStreet11 = GetLocalInt(OBJECT_SELF,"iStreet11");
int ixStreet12 = GetLocalInt(OBJECT_SELF,"iStreet12");

string sxSUHit = GetLocalString(OBJECT_SELF,"sSUHit");
sxSUHit = "";
SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");

string sxRB = GetLocalString(OBJECT_SELF,"sRB");
sxRB = "";
SetLocalString(OBJECT_SELF,"sRB","sxRB");

string sxHL = GetLocalString(OBJECT_SELF,"sHL");
sxHL = "";
SetLocalString(OBJECT_SELF,"sHL","sxHL");

string sxEO = GetLocalString(OBJECT_SELF,"sEO");
sxEO = "";
SetLocalString(OBJECT_SELF,"sEO","sxEO");

string sxDoz = GetLocalString(OBJECT_SELF,"sDoz");
sxDoz = "";
SetLocalString(OBJECT_SELF,"sDoz","sxDoz");

string sxCol = GetLocalString(OBJECT_SELF,"sCol");
sxCol = "";
SetLocalString(OBJECT_SELF,"sCol","sxCol");

string sxLine = GetLocalString(OBJECT_SELF,"sLine");
sxLine = "";
SetLocalString(OBJECT_SELF,"sLine","sxLine");

string sxStreet = GetLocalString(OBJECT_SELF,"sStreet");
sxStreet = "";
SetLocalString(OBJECT_SELF,"sStreet","sxStreet");


int ixSpot1 = GetLocalInt(OBJECT_SELF,"iSpot1");
string sxSpot1Color = GetLocalString(OBJECT_SELF,"sSpot1Color");


ixSpot1 = Random(36);
SetLocalInt(OBJECT_SELF,"iSpot1", ixSpot1);

switch(ixSpot1)
    {
    case 0:
    sxSpot1Color = "Green";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ix0su*36);
    if (ix0su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix0su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    break;

    case 1:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
        if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
            if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                    if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix1su*36);
        if (ix1su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix1su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine1*6);
                if (ixLine1 >= 1)
        {
        sxLine = "Your Street bet of "+IntToString(ixLine1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixStreet1*12);
                if (ixStreet1 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 2:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
            if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                    if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix2su*36);
        if (ix2su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix2su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine1*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet1*12);
            if (ixStreet1 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 3:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix3su*36);
        if (ix3su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix3su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine1*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet1*12);
            if (ixStreet1 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 4:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix4su*36);
        if (ix4su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix4su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine1*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine2*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet2*12);
            if (ixStreet2 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 5:
    sxSpot1Color = "Red";
SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix5su*36);
    if (ix5su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix5su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine1*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine2*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet2*12);
            if (ixStreet2 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 6:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix6su*36);
    if (ix6su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix6su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine1*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine2*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet2*12);
            if (ixStreet2 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 7:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix7su*36);
    if (ix7su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix7su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine2*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine3*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet3*12);
            if (ixStreet3 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 8:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix8su*36);
    if (ix8su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix8su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine2*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine3*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet3*12);
            if (ixStreet3 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 9:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix9su*36);
    if (ix9su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix9su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine2*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine3*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet3*12);
            if (ixStreet3 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 10:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix10su*36);
    if (ix10su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix10su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine3*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine4*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet4*12);
            if (ixStreet4 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet4)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 11:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix11su*36);
    if (ix11su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix11su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine3*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine4*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet4*12);
            if (ixStreet4 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet4)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 12:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz1*3);
                    if (ixDoz1 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix12su*36);
    if (ix12su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix12su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine3*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine4*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet4*12);
            if (ixStreet4 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet4)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 13:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
                    if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix13su*36);
    if (ix13su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix13su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine4*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine5*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet5*12);
            if (ixStreet5 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet5)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 14:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
                    if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix14su*36);
    if (ix14su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix14su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine4*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine5*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet5*12);
            if (ixStreet5 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet5)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 15:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
                    if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix15su*36);
    if (ix15su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix15su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine4*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine5*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet5*12);
            if (ixStreet5 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet5)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 16:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
                    if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix16su*36);
    if (ix16su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix16su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine5*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine6*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet6*12);
            if (ixStreet6 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet6)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 17:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
                   if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix17su*36);
    if (ix17su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix17su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine5*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine6*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet6*12);
            if (ixStreet6 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet6)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 18:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLow*2);
                if (ixLow >= 1)
        {
        sxHL = "Your Low bet of "+IntToString(ixLow)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
               if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix18su*36);
    if (ix18su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix18su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine5*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine6*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet6*12);
            if (ixStreet6 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet6)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 19:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
               if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix19su*36);
    if (ix19su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix19su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine6*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine7*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet7*12);
            if (ixStreet7 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet7)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 20:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
               if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix20su*36);
    if (ix20su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix20su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine6*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine7*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet7*12);
            if (ixStreet7 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet7)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 21:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
               if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix21su*36);
    if (ix21su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix21su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine6*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine7*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet7*12);
            if (ixStreet7 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet7)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 22:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
               if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix22su*36);
    if (ix22su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix22su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine7*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine8*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet8*12);
            if (ixStreet8 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet8)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 23:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
               if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix23su*36);
    if (ix23su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix23su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine7*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine8*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet8*12);
            if (ixStreet8 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet8)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 24:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz2*3);
               if (ixDoz2 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix24su*36);
    if (ix24su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix24su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine7*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine8*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet8*12);
            if (ixStreet8 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet8)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 25:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
               if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix25su*36);
    if (ix25su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix25su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine8*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine9*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet9*12);
            if (ixStreet9 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet9)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 26:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix26su*36);
    if (ix26su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix26su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine8*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine9*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet9*12);
            if (ixStreet9 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet9)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 27:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix27su*36);
    if (ix27su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix27su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine8*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine9*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet9*12);
            if (ixStreet9 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet9)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 28:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix28su*36);
    if (ix28su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix28su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine9*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine10*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet10*12);
            if (ixStreet10 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet10)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 29:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix29su*36);
    if (ix29su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix29su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine9*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine10*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet10*12);
            if (ixStreet10 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet10)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 30:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix30su*36);
    if (ix30su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix30su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine9*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine10*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet10*12);
            if (ixStreet10 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet10)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 31:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix31su*36);
    if (ix31su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix31su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine10*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine11*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet11*12);
            if (ixStreet11 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet11)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 32:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix32su*36);
    if (ix32su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix32su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine10*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine11*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet11*12);
            if (ixStreet11 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet11)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 33:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix33su*36);
    if (ix33su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix33su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine10*6);
    GiveGoldToCreature(GetPCSpeaker(),ixLine11*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet11*12);
            if (ixStreet11 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet11)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 34:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol1*3);
                if (ixCol1 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol1)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix34su*36);
    if (ix34su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix34su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine11*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet12*12);
            if (ixStreet12 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet12)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 35:
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixBlack*2);
                if (ixBlack >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixOdd*2);
                    if (ixOdd >= 1)
        {
        sxEO = "Your Odd bet of "+IntToString(ixOdd)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol2*3);
                if (ixCol2 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol2)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix35su*36);
    if (ix35su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix35su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine11*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet12*12);
            if (ixStreet12 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet12)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;

    case 36:
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(GetPCSpeaker(),ixRed*2);
            if (ixRed >= 1)
        {
        sxRB = "Your "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit!";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixHigh*2);
                    if (ixHigh >= 1)
        {
        sxHL = "Your High bet of "+IntToString(ixHigh)+" has hit!";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixEven*2);
                        if (ixEven >= 1)
        {
        sxEO = "Your Even bet of "+IntToString(ixEven)+" has hit!";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixDoz3*3);
           if (ixDoz3 >= 1)
        {
        sxDoz = "Your Dozen bet of "+IntToString(ixDoz3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixCol3*3);
                if (ixCol3 >= 1)
        {
        sxCol = "Your Column bet of "+IntToString(ixCol3)+" has hit!";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    GiveGoldToCreature(GetPCSpeaker(),ix36su*36);
    if (ix36su >= 1)
        {
        sxSUHit = "Your Straight Up bet of "+IntToString(ix36su)+" has hit!";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    GiveGoldToCreature(GetPCSpeaker(),ixLine11*6);
    GiveGoldToCreature(GetPCSpeaker(),ixStreet12*12);
            if (ixStreet12 >= 1)
        {
        sxStreet = "Your Street bet of "+IntToString(ixStreet12)+" has hit!";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    break;
}

SetCustomToken(300,(sxSpot1Color)+" "+IntToString(ixSpot1));
SetCustomToken(301,(sxSUHit));
SetCustomToken(302,(sxRB));
SetCustomToken(303,(sxHL));
SetCustomToken(304,(sxEO));
SetCustomToken(305,(sxDoz));
SetCustomToken(306,(sxCol));
SetCustomToken(307,(sxLine));
SetCustomToken(308,(sxStreet));
}
