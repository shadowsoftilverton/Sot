#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: UW_INC_CYPHER.NSS                                                      :://
//:: Silver Marches Script                                                  :://
//::////////////////////////////////////////////////////////////////////////:://
/*
    This file was originally created by FunkySwerve. I make no claims of having
    hand in this particular file beyond minor updates. This came from:

    "SIMTools V3.0 Speech Integration & Management Tools Version 3.0"

    The original credits are as follows:

    "Dumbo - for his amazing plugin
    Virusman - for Linux versions, and for the reset plugin, and for
        his excellent events plugin, without which this update would not
        be possible
    Dazzle - for his script samples
    Butch - for the emote wand scripts
    The DMFI project - for the languages conversions and many of the emotes
     Lanessar and the players of the Myth Drannor PW - for the new languages
     The players and DMs of Higher Ground for their input and playtesting"
*/
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By: FunkySwerve                                                :://
//:: Created On: April 4 2006                                               :://
//:: Last Updated: March 27 2007                                            :://
//::////////////////////////////////////////////////////////////////////////:://

string ConvertUndercommon(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate =
"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "u";
    case 1: return "h";
    case 2: return "s";
    case 3: return "w";
    case 4: return "o";
    case 5: return "a";
    case 6: return "b";
    case 7: return "t";
    case 8: return "e";
    case 9: return "kk";
    case 10: return "n";
    case 11: return "c";
    case 12: return "z";
    case 13: return "l";
    case 14: return "i";
    case 15: return "d";
    case 16: return "f";
    case 17: return "m";
    case 18: return "r";
    case 19: return "n";
    case 20: return "y";
    case 21: return "x";
    case 22: return "bb";
    case 23: return "dr";
    case 24: return "gi";
    case 25: return "jh";
    case 26: return "U";
    case 27: return "H";
    case 28: return "S";
    case 29: return "W";
    case 30: return "O";
    case 31: return "A";
    case 32: return "B";
    case 33: return "T";
    case 34: return "E";
    case 35: return "KK";
    case 36: return "N";
    case 37: return "C";
    case 38: return "Z";
    case 39: return "L";
    case 40: return "I";
    case 41: return "D";
    case 42: return "F";
    case 43: return "M";
    case 44: return "R";
    case 45: return "N";
    case 46: return "Y";
    case 47: return "X";
    case 48: return "BB";
    case 49: return "Dr";
    case 50: return "Gi";
    case 51: return "Jh";
    default: return sLetter; } return "";
}

string ProcessUndercommon(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertUndercommon(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertAquan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "ha";
    case 26: return "Ha";
    case 1: return "p";
    case 2: return "z";
    case 3: return "j";
    case 4: return "o";
    case 5: return "";
    case 6: return "c";
    case 7: return "r";
    case 8: return "a";
    case 9: return "m";
    case 10: return "s";
    case 11: return "h";
    case 12: return "r";
    case 13: return "k";
    case 14: return "u";
    case 15: return "b";
    case 16: return "d";
    case 17: return "h";
    case 18: return "y";
    case 19: return "n";
    case 20: return "";
    case 21: return "i";
    case 22: return "r";
    case 23: return "r";
    case 24: return "'";
    case 25: return "m";
    case 27: return "Ph";
    case 28: return "Z";
    case 29: return "Th";
    case 30: return "O";
    case 31: return "";
    case 32: return "Ff";
    case 33: return "Rrs";
    case 34: return "A";
    case 35: return "M";
    case 36: return "Gh";
    case 37: return "H";
    case 38: return "R";
    case 39: return "S";
    case 40: return "U";
    case 41: return "B";
    case 42: return "Cs";
    case 43: return "Ha";
    case 44: return "Se";
    case 45: return "Ne";
    case 46: return "";
    case 47: return "G";
    case 48: return "R";
    case 49: return "R";
    case 50: return "'";
    case 51: return "N";
    default: return sLetter; } return "";
}

string ProcessAquan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertAquan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertAuran(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "Wh";
    case 26: return "Wys";
    case 1: return "Yss";
    case 2: return "S";
    case 3: return "Y";
    case 4: return "W";
    case 5: return "o";
    case 6: return "C";
    case 7: return "u";
    case 8: return "S";
    case 9: return "Ss";
    case 10: return "Oo";
    case 11: return "io";
    case 12: return "i";
    case 13: return "f";
    case 14: return "ph";
    case 15: return "pys";
    case 16: return "sys";
    case 17: return "se";
    case 18: return "eu";
    case 19: return "u";
    case 20: return "J";
    case 21: return "A";
    case 22: return "Ae";
    case 23: return ".O";
    case 24: return "e. A";
    case 25: return "Ab";
    case 27: return "b";
    case 28: return "Y";
    case 29: return "we";
    case 30: return "ye";
    case 31: return "se";
    case 32: return "sy";
    case 33: return "s";
    case 34: return "Y";
    case 35: return "U";
    case 36: return "I";
    case 37: return "O";
    case 38: return "W";
    case 39: return "e";
    case 40: return "wY";
    case 41: return "cA";
    case 42: return "ac";
    case 43: return "jh";
    case 44: return "ah";
    case 45: return "ha";
    case 46: return "v";
    case 47: return "th";
    case 48: return "gh";
    case 49: return "vy";
    case 50: return "uy";
    case 51: return "el";
    default: return sLetter; } return "";
}

string ProcessAuran(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertAuran(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertGiant(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "Ugh";
    case 1: return "Gk";
    case 2: return "K";
    case 3: return "gj";
    case 4: return "j";
    case 5: return "r";
    case 6: return "t";
    case 7: return "u";
    case 8: return "i";
    case 9: return "s";
    case 10: return "S";
    case 11: return "a";
    case 12: return "V";
    case 13: return "G";
    case 14: return "H";
    case 15: return "X";
    case 16: return "R";
    case 17: return "We";
    case 18: return "Rt";
    case 19: return "Jk";
    case 20: return "Jk";
    case 21: return "jk";
    case 22: return "kj";
    case 23: return "ty";
    case 24: return "tr";
    case 25: return "lp";
    case 26: return "plop";
    case 27: return "qrk";
    case 28: return "cd";
    case 29: return "dg";
    case 30: return "fhg";
    case 31: return "hgf";
    case 32: return "gty";
    case 33: return "rk";
    case 34: return "er";
    case 35: return "gh";
    case 36: return "kj";
    case 37: return "r";
    case 38: return "t";
    case 39: return "s";
    case 40: return "v";
    case 41: return "s";
    case 42: return "a";
    case 43: return "h";
    case 44: return "t";
    case 45: return "k";
    case 46: return "y";
    case 47: return "h";
    case 48: return "u";
    case 49: return "i";
    case 50: return "j";
    case 51: return "w";
    default: return sLetter; } return "";
}

string ProcessGiant(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertGiant(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertGnoll(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "Gr";
    case 1: return "gr";
    case 2: return "ra";
    case 3: return "wr";
    case 4: return "aw";
    case 5: return "Wr";
    case 6: return "rA";
    case 7: return "Ra";
    case 8: return "gR";
    case 9: return "yip";
    case 10: return "yi";
    case 11: return "Ip";
    case 12: return "ep";
    case 13: return "Ee";
    case 14: return "eE";
    case 15: return "Ep";
    case 16: return "yw";
    case 17: return "ra";
    case 18: return "wa";
    case 19: return "yee";
    case 20: return "ngh";
    case 21: return "u";
    case 22: return "gn";
    case 23: return "ol";
    case 24: return "l";
    case 25: return "en";
    case 26: return "gh";
    case 27: return "yee";
    case 28: return "ey";
    case 29: return "eh";
    case 30: return "pf";
    case 31: return "ph";
    case 32: return "er";
    case 33: return "kip";
    case 34: return "kI";
    case 35: return "Ip";
    case 36: return "Ye";
    case 37: return "En";
    case 38: return "Gh";
    case 39: return "uU";
    case 40: return "yw";
    case 41: return "y";
    case 42: return "o";
    case 43: return "n";
    case 44: return "d";
    case 45: return "a";
    case 46: return "l";
    case 47: return "l";
    case 48: return "arf";
    case 49: return "a";
    case 50: return "r";
    case 51: return "f";
    default: return sLetter; } return "";
}

string ProcessGnoll(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertGnoll(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertIgnan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "k";
    case 1: return "ra";
    case 2: return "kk";
    case 3: return "le";
    case 4: return "kr";
    case 5: return "ck";
    case 6: return "k k";
    case 7: return "-";
    case 8: return "sk";
    case 9: return "k";
    case 10: return "ig";
    case 11: return "g";
    case 12: return "na";
    case 13: return "hh";
    case 14: return "k";
    case 15: return "n";
    case 16: return "hu";
    case 17: return "kc";
    case 18: return "kr";
    case 19: return "cr";
    case 20: return "rc";
    case 21: return "k";
    case 22: return "rk";
    case 23: return "ckl";
    case 24: return "zk";
    case 25: return "";
    case 26: return "hhh";
    case 27: return "kz";
    case 28: return "k";
    case 29: return "kk";
    case 30: return "h-";
    case 31: return "ha";
    case 32: return " k";
    case 33: return "te";
    case 34: return "'k";
    case 35: return "la";
    case 36: return "r'";
    case 37: return "ng";
    case 38: return "'";
    case 39: return "mr";
    case 40: return "ak";
    case 41: return "ua";
    case 42: return "i";
    case 43: return "ge";
    case 44: return "f";
    case 45: return "'r";
    case 46: return "ss";
    case 47: return "er";
    case 48: return "re";
    case 49: return "r";
    case 50: return "fi";
    case 51: return "e";
    default: return sLetter; } return "";
}

string ProcessIgnan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertIgnan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertSylvan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "s";
    case 1: return "F";
    case 2: return "y";
    case 3: return "E";
    case 4: return "l";
    case 5: return "Y";
    case 6: return "v";
    case 7: return "Tr";
    case 8: return "a";
    case 9: return "Ee";
    case 10: return "n";
    case 11: return "Ny";
    case 12: return "mp";
    case 13: return "h";
    case 14: return "M";
    case 15: return "jo";
    case 16: return "li";
    case 17: return "nar";
    case 18: return "shr";
    case 19: return "ub";
    case 20: return "Whi";
    case 21: return "his";
    case 22: return "ssp";
    case 23: return "pey";
    case 24: return "tee";
    case 25: return "hee";
    case 26: return "na";
    case 27: return "At";
    case 28: return "Tu";
    case 29: return "Ure";
    case 30: return "aN";
    case 31: return "wh'";
    case 32: return "sy'";
    case 33: return "'l'v";
    case 34: return "-";
    case 35: return "Sy";
    case 36: return "'s";
    case 37: return "yu";
    case 38: return "el";
    case 39: return "Si'";
    case 40: return "lv";
    case 41: return "ll'";
    case 42: return "ve";
    case 43: return "ee";
    case 44: return "E";
    case 45: return "en";
    case 46: return "S";
    case 47: return "Y";
    case 48: return "Wy";
    case 49: return "Yv";
    case 50: return "Ki";
    case 51: return "tT";
    default: return sLetter; } return "";
}

string ProcessSylvan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertSylvan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertTerran(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "R";
    case 1: return "T";
    case 2: return "E";
    case 3: return "T";
    case 4: return "C";
    case 5: return "ter";
    case 6: return "O";
    case 7: return "A";
    case 8: return "l";
    case 9: return "rra";
    case 10: return "oO";
    case 11: return "R";
    case 12: return "E";
    case 13: return "C";
    case 14: return "for";
    case 15: return "d";
    case 16: return "T";
    case 17: return "Rr";
    case 18: return "D";
    case 19: return "h";
    case 20: return "K";
    case 21: return "mi";
    case 22: return "D";
    case 23: return "S";
    case 24: return "A";
    case 25: return "ng";
    case 26: return "t";
    case 27: return "wa";
    case 28: return "rf";
    case 29: return "wa";
    case 30: return "N";
    case 31: return "o";
    case 32: return "rph";
    case 33: return "cO";
    case 34: return "n";
    case 35: return "Nc";
    case 36: return "r";
    case 37: return "ete";
    case 38: return "di";
    case 39: return "e";
    case 40: return "rT";
    case 41: return "mu";
    case 42: return "d";
    case 43: return "s";
    case 44: return "Mn";
    case 45: return "in";
    case 46: return "ni";
    case 47: return "ng";
    case 48: return "i'";
    case 49: return "Kr";
    case 50: return "Umb";
    case 51: return "Le";
    default: return sLetter; } return "";
}

string ProcessTerran(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertTerran(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertTreant(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "Tr";
    case 1: return "O";
    case 2: return "ee";
    case 3: return "ak";
    case 4: return "ant";
    case 5: return "Bi";
    case 6: return "Pi";
    case 7: return "rch";
    case 8: return "Tr";
    case 9: return "neh";
    case 10: return "trr";
    case 11: return "lea";
    case 12: return "Ee";
    case 13: return "bra";
    case 14: return "ves";
    case 15: return "-";
    case 16: return "Be";
    case 17: return "nch";
    case 18: return "Tr'";
    case 19: return "ches";
    case 20: return "Ar";
    case 21: return "iro";
    case 22: return "noa";
    case 23: return "Rd";
    case 24: return "K'k";
    case 25: return "nwo";
    case 26: return "ood";
    case 27: return "Corr'";
    case 28: return "wo";
    case 29: return "od";
    case 30: return "ne'";
    case 31: return "'dle";
    case 32: return "Au't";
    case 33: return "uM";
    case 34: return "sto";
    case 35: return "Orum";
    case 36: return "eer";
    case 37: return "ert";
    case 38: return "kao";
    case 39: return "kra";
    case 40: return "ab";
    case 41: return "eni";
    case 42: return "ipe";
    case 43: return "pap";
    case 44: return "re";
    case 45: return "eR";
    case 46: return "Pu";
    case 47: return "lP";
    case 48: return "Cy";
    case 49: return "kle";
    case 50: return "chn";
    case 51: return "br";
    default: return sLetter; } return "";
}

string ProcessTreant(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertTreant(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertAlgarondan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "a";
    case 1: return "u";
    case 2: return "l";
    case 3: return "s";
    case 4: return "g";
    case 5: return "e";
    case 6: return "a";
    case 7: return "s";
    case 8: return "r";
    case 9: return "E";
    case 10: return "o";
    case 11: return "l";
    case 12: return "n";
    case 13: return "v";
    case 14: return "d";
    case 15: return "E";
    case 16: return "a";
    case 17: return "n";
    case 18: return "n";
    case 19: return "A";
    case 20: return "A";
    case 21: return "l";
    case 22: return "L";
    case 23: return "f";
    case 24: return "T";
    case 25: return "'";
    case 26: return "-";
    case 27: return "U";
    case 28: return "";
    case 29: return "M";
    case 30: return "U";
    case 31: return "B";
    case 32: return "L";
    case 33: return "A";
    case 34: return "T";
    case 35: return "I";
    case 36: return "R";
    case 37: return "A";
    case 38: return "A";
    case 39: return "N";
    case 40: return "K";
    case 41: return "U";
    case 42: return "Ll";
    case 43: return "iL";
    case 44: return "N";
    case 45: return "r";
    case 46: return "e";
    case 47: return "T";
    case 48: return "ph";
    case 49: return "Hj";
    case 50: return "t";
    case 51: return "te";
    default: return sLetter; } return "";
}

string ProcessAlgarondan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertAlgarondan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertAlzhedo(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "o";
    case 1: return "d";
    case 2: return "e";
    case 3: return "h";
    case 4: return "zee";
    case 5: return "ull";
    case 6: return "a";
    case 7: return "n";
    case 8: return "A";
    case 9: return "ah";
    case 10: return "c";
    case 11: return "nn";
    case 12: return "i";
    case 13: return "m";
    case 14: return "l";
    case 15: return "Ca";
    case 16: return "O";
    case 17: return "N";
    case 18: return "R";
    case 19: return "A";
    case 20: return "D";
    case 21: return "W";
    case 22: return "E";
    case 23: return "A";
    case 24: return "R";
    case 25: return "L";
    case 26: return "eRe";
    case 27: return "R";
    case 28: return "N";
    case 29: return "N";
    case 30: return "I";
    case 31: return "Dh";
    case 32: return "T";
    case 33: return "A";
    case 34: return "Ee";
    case 35: return "R";
    case 36: return "G";
    case 37: return "N";
    case 38: return "B";
    case 39: return "A";
    case 40: return "Sh";
    case 41: return "IM";
    case 42: return "LL";
    case 43: return "A";
    case 44: return "C";
    case 45: return "O";
    case 46: return "D";
    case 47: return "E";
    case 48: return "H";
    case 49: return "Z";
    case 50: return "L";
    case 51: return "A";
    default: return sLetter; } return "";
}

string ProcessAlzhedo(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertAlzhedo(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertChessentan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "N";
    case 1: return "A";
    case 2: return "T";
    case 3: return "N";
    case 4: return "E";
    case 5: return "S";
    case 6: return "S";
    case 7: return "E";
    case 8: return "H";
    case 9: return "C";
    case 10: return "N";
    case 11: return "O";
    case 12: return "M";
    case 13: return "M";
    case 14: return "O";
    case 15: return "C";
    case 16: return "Y";
    case 17: return "B";
    case 18: return "Y";
    case 19: return "A";
    case 20: return "M";
    case 21: return "N";
    case 22: return "a";
    case 23: return "I";
    case 24: return "g";
    case 25: return "A";
    case 26: return "i";
    case 27: return "G";
    case 28: return "n";
    case 29: return "A";
    case 30: return "p";
    case 31: return "";
    case 32: return "o";
    case 33: return ".";
    case 34: return "o";
    case 35: return "g'";
    case 36: return "h";
    case 37: return "c'";
    case 38: return "a";
    case 39: return "m'";
    case 40: return "l";
    case 41: return " ";
    case 42: return "pi";
    case 43: return "'";
    case 44: return "re";
    case 45: return "h";
    case 46: return "f";
    case 47: return "Yd";
    case 48: return "s";
    case 49: return "Gj";
    case 50: return "l";
    case 51: return "jG";
    default: return sLetter; } return "";
}

string ProcessChessentan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertChessentan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertChondathan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "eh";
    case 1: return "bee";
    case 2: return "sea";
    case 3: return "de";
    case 4: return "e";
    case 5: return "eph";
    case 6: return "gee";
    case 7: return "ehtch";
    case 8: return "eye";
    case 9: return "jae";
    case 10: return "kay";
    case 11: return "ell";
    case 12: return "emm";
    case 13: return "en";
    case 14: return "oh";
    case 15: return "pee";
    case 16: return "kue";
    case 17: return "arr";
    case 18: return "es";
    case 19: return "tea";
    case 20: return "you";
    case 21: return "vea";
    case 22: return "uu";
    case 23: return "why";
    case 24: return "ex";
    case 25: return "zee";
    case 26: return "EH";
    case 27: return "BEE";
    case 28: return "SEA";
    case 29: return "DE";
    case 30: return "E";
    case 31: return "EPH";
    case 32: return "GEE";
    case 33: return "EHTCH";
    case 34: return "EYE";
    case 35: return "JAE";
    case 36: return "KAY";
    case 37: return "ELL";
    case 38: return "EMM";
    case 39: return "EN";
    case 40: return "OH";
    case 41: return "PEE";
    case 42: return "KUE";
    case 43: return "ARR";
    case 44: return "ES";
    case 45: return "TEA";
    case 46: return "YOU";
    case 47: return "VEA";
    case 48: return "UU";
    case 49: return "WHY";
    case 50: return "EX";
    case 51: return "ZEE";
    default: return sLetter; } return "";
}

string ProcessChondathan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertChondathan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertChultan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "n";
    case 2: return "e";
    case 3: return "a";
    case 4: return "o";
    case 5: return "t";
    case 6: return "t";
    case 7: return "v";
    case 8: return "a";
    case 9: return "l";
    case 10: return "e";
    case 11: return "l";
    case 12: return "u";
    case 13: return "l";
    case 14: return "s";
    case 15: return "h";
    case 16: return "b";
    case 17: return "n";
    case 18: return "C";
    case 19: return "o";
    case 20: return "t";
    case 21: return "r";
    case 22: return "o";
    case 23: return "a";
    case 24: return "R";
    case 25: return "K";
    case 26: return "E";
    case 27: return "P";
    case 28: return "";
    case 29: return "H";
    case 30: return "U";
    case 31: return ",";
    case 32: return "S";
    case 33: return "R";
    case 34: return "-";
    case 35: return "A";
    case 36: return "P";
    case 37: return "'";
    case 38: return "W";
    case 39: return " ";
    case 40: return "Y";
    case 41: return "H";
    case 42: return "L";
    case 43: return "E";
    case 44: return "S";
    case 45: return "E";
    case 46: return "K";
    case 47: return "I";
    case 48: return "M";
    case 49: return "N";
    case 50: return "D";
    case 51: return "O";
    default: return sLetter; } return "";
}

string ProcessChultan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertChultan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertDamaran(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "a";
    case 2: return "a";
    case 3: return "a";
    case 4: return "e";
    case 5: return "s";
    case 6: return "r";
    case 7: return "s";
    case 8: return "a";
    case 9: return "a";
    case 10: return "n";
    case 11: return "a";
    case 12: return "n";
    case 13: return "o";
    case 14: return "v";
    case 15: return "a";
    case 16: return "o";
    case 17: return "e";
    case 18: return "d";
    case 19: return "m";
    case 20: return "l";
    case 21: return "k";
    case 22: return "l";
    case 23: return "a";
    case 24: return "S";
    case 25: return "l";
    case 26: return "D";
    case 27: return "E";
    case 28: return "R";
    case 29: return "T";
    case 30: return "H";
    case 31: return "A";
    case 32: return "A";
    case 33: return "T";
    case 34: return "N";
    case 35: return "E";
    case 36: return "F";
    case 37: return "R";
    case 38: return "U";
    case 39: return "R";
    case 40: return "T";
    case 41: return "L";
    case 42: return "G";
    case 43: return "I";
    case 44: return "S";
    case 45: return "P";
    case 46: return "H";
    case 47: return "M";
    case 48: return "G";
    case 49: return "I";
    case 50: return "A";
    case 51: return "S";
    default: return sLetter; } return "";
}

string ProcessDamaran(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertDamaran(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertDambrathan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "h";
    case 2: return "f";
    case 3: return "a";
    case 4: return "a";
    case 5: return "s";
    case 6: return "h";
    case 7: return "v";
    case 8: return " ";
    case 9: return "t";
    case 10: return "e";
    case 11: return ".";
    case 12: return "a";
    case 13: return "a";
    case 14: return ",";
    case 15: return "r";
    case 16: return "d";
    case 17: return "n";
    case 18: return "b";
    case 19: return "a";
    case 20: return "i";
    case 21: return "m";
    case 22: return "J";
    case 23: return "S";
    case 24: return "C";
    case 25: return "R";
    case 26: return "S";
    case 27: return "E";
    case 28: return "E";
    case 29: return "d";
    case 30: return "'";
    case 31: return "T";
    case 32: return "a";
    case 33: return "N";
    case 34: return "T";
    case 35: return "A";
    case 36: return "E";
    case 37: return "H";
    case 38: return "Y";
    case 39: return "T";
    case 40: return "L";
    case 41: return "A";
    case 42: return "N";
    case 43: return "R";
    case 44: return "E";
    case 45: return "B";
    case 46: return "V";
    case 47: return "M";
    case 48: return "L";
    case 49: return "A";
    case 50: return "E";
    case 51: return "D";
    default: return sLetter; } return "";
}

string ProcessDambrathan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertDambrathan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertDurpari(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "i";
    case 1: return "b";
    case 2: return "r";
    case 3: return "s";
    case 4: return "a";
    case 5: return "e";
    case 6: return "p";
    case 7: return "s";
    case 8: return "r";
    case 9: return "t";
    case 10: return "u";
    case 11: return "a";
    case 12: return "d";
    case 13: return "g";
    case 14: return "a";
    case 15: return "o";
    case 16: return "v";
    case 17: return "n";
    case 18: return "r";
    case 19: return "d";
    case 20: return "v";
    case 21: return "N";
    case 22: return "e";
    case 23: return "U";
    case 24: return "l";
    case 25: return "G";
    case 26: return "d";
    case 27: return "A";
    case 28: return "o";
    case 29: return "T";
    case 30: return "r";
    case 31: return "S";
    case 32: return "n";
    case 33: return "E";
    case 34: return "A";
    case 35: return "C";
    case 36: return "R";
    case 37: return "O";
    case 38: return "E";
    case 39: return "M";
    case 40: return "M";
    case 41: return "M";
    case 42: return "A";
    case 43: return "O";
    case 44: return "C";
    case 45: return "N";
    case 46: return "L";
    case 47: return " ";
    case 48: return "I";
    case 49: return "G";
    case 50: return "N";
    case 51: return "O";
    default: return sLetter; } return "";
}

string ProcessDurpari(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertDurpari(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertHalardrim(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "m";
    case 1: return "t";
    case 2: return "i";
    case 3: return "h";
    case 4: return "r";
    case 5: return "r";
    case 6: return "d";
    case 7: return "e";
    case 8: return "r";
    case 9: return "s";
    case 10: return "a";
    case 11: return "k";
    case 12: return "l";
    case 13: return "a";
    case 14: return "e";
    case 15: return "l";
    case 16: return "h";
    case 17: return "t";
    case 18: return "c";
    case 19: return "h";
    case 20: return "a";
    case 21: return "a";
    case 22: return "r";
    case 23: return "R";
    case 24: return "T";
    case 25: return "I";
    case 26: return "E";
    case 27: return "S";
    case 28: return "R";
    case 29: return "S";
    case 30: return "M";
    case 31: return "E";
    case 32: return "A";
    case 33: return "C";
    case 34: return "J";
    case 35: return "R";
    case 36: return "O";
    case 37: return "O";
    case 38: return "R";
    case 39: return "F";
    case 40: return "M";
    case 41: return "R";
    case 42: return "I";
    case 43: return "Y";
    case 44: return "L";
    case 45: return "T";
    case 46: return "I";
    case 47: return "E";
    case 48: return "T";
    case 49: return "He";
    case 50: return "A";
    case 51: return "'X";
    default: return sLetter; } return "";
}

string ProcessHalardrim(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertHalardrim(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertHalruaan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "l";
    case 2: return "a";
    case 3: return "a";
    case 4: return "a";
    case 5: return "r";
    case 6: return "u";
    case 7: return "b";
    case 8: return "r";
    case 9: return "m";
    case 10: return "l";
    case 11: return "i";
    case 12: return "a";
    case 13: return "n";
    case 14: return "h";
    case 15: return "ni";
    case 16: return "s";
    case 17: return "i";
    case 18: return "h";
    case 19: return "c";
    case 20: return "i";
    case 21: return "d";
    case 22: return "N";
    case 23: return "Ra";
    case 24: return "I";
    case 25: return "R";
    case 26: return "Ck";
    case 27: return "N";
    case 28: return "C";
    case 29: return "G";
    case 30: return "S";
    case 31: return "S";
    case 32: return "D";
    case 33: return "O";
    case 34: return "N";
    case 35: return "U";
    case 36: return "U";
    case 37: return "T";
    case 38: return "O";
    case 39: return "H";
    case 40: return "";
    case 41: return "O";
    case 42: return "N";
    case 43: return "H";
    case 44: return "T";
    case 45: return "E";
    case 46: return "I";
    case 47: return "G";
    case 48: return "Az";
    case 49: return "A";
    case 50: return "'uth";
    case 51: return "M";
    default: return sLetter; } return "";
}

string ProcessHalruaan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertHalruaan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertIlluskan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "nr";
    case 2: return "a";
    case 3: return "r";
    case 4: return "k";
    case 5: return "a";
    case 6: return "s";
    case 7: return "t";
    case 8: return "u";
    case 9: return "n";
    case 10: return "l";
    case 11: return "i";
    case 12: return "l";
    case 13: return "m";
    case 14: return "i";
    case 15: return " ";
    case 16: return "mo";
    case 17: return "e";
    case 18: return "o";
    case 19: return "m";
    case 20: return "n";
    case 21: return "o";
    case 22: return "s";
    case 23: return "S";
    case 24: return "H";
    case 25: return "A";
    case 26: return "A";
    case 27: return "V";
    case 28: return "E";
    case 29: return "A";
    case 30: return "S";
    case 31: return "G";
    case 32: return "E";
    case 33: return "R";
    case 34: return "N";
    case 35: return "U";
    case 36: return "O";
    case 37: return "A";
    case 38: return "R";
    case 39: return "T";
    case 40: return "T";
    case 41: return "H";
    case 42: return "H";
    case 43: return "Y";
    case 44: return "'U";
    case 45: return "M";
    case 46: return "T";
    case 47: return "-G";
    case 48: return "H";
    case 49: return "R";
    case 50: return "Gy";
    case 51: return " a";
    default: return sLetter; } return "";
}

string ProcessIlluskan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertIlluskan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertImaskar(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "r";
    case 1: return "U";
    case 2: return "a";
    case 3: return "n";
    case 4: return "k";
    case 5: return "t";
    case 6: return "s";
    case 7: return "h";
    case 8: return "a";
    case 9: return "e";
    case 10: return "m";
    case 11: return "r";
    case 12: return "i";
    case 13: return "d";
    case 14: return "l";
    case 15: return "n";
    case 16: return "a";
    case 17: return "a";
    case 18: return "i";
    case 19: return "r";
    case 20: return "t";
    case 21: return "o";
    case 22: return "a";
    case 23: return "H";
    case 24: return "I";
    case 25: return "L";
    case 26: return "L";
    case 27: return "U";
    case 28: return "E";
    case 29: return "M";
    case 30: return "C";
    case 31: return "T";
    case 32: return " ";
    case 33: return "H";
    case 34: return "'";
    case 35: return "I";
    case 36: return "Hs";
    case 37: return "S";
    case 38: return "Gr";
    case 39: return "IS";
    case 40: return "Ge";
    case 41: return "S";
    case 42: return "E";
    case 43: return "I";
    case 44: return "E";
    case 45: return "HL";
    case 46: return "H";
    case 47: return "L";
    case 48: return "E";
    case 49: return "Y";
    case 50: return "T";
    case 51: return "E";
    default: return sLetter; } return "";
}

string ProcessImaskar(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertImaskar(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertLantanese(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "e";
    case 1: return "g";
    case 2: return "s";
    case 3: return "n";
    case 4: return "e";
    case 5: return "o";
    case 6: return "n";
    case 7: return "m";
    case 8: return "a";
    case 9: return "e";
    case 10: return "t";
    case 11: return "p";
    case 12: return "n";
    case 13: return "o";
    case 14: return "a";
    case 15: return "w";
    case 16: return "l";
    case 17: return "e";
    case 18: return "r";
    case 19: return "U";
    case 20: return " ";
    case 21: return "p";
    case 22: return "e'";
    case 23: return "W";
    case 24: return "S";
    case 25: return "Ith";
    case 26: return "E";
    case 27: return "Ca";
    case 28: return "A";
    case 29: return "Ra";
    case 30: return "T";
    case 31: return "Zy";
    case 32: return "S";
    case 33: return "I";
    case 34: return "O";
    case 35: return "F";
    case 36: return "N";
    case 37: return "R";
    case 38: return "V";
    case 39: return "A";
    case 40: return "E";
    case 41: return "G";
    case 42: return "N";
    case 43: return "E";
    case 44: return "T";
    case 45: return "G";
    case 46: return "I";
    case 47: return "N";
    case 48: return "O";
    case 49: return "S";
    case 50: return "N";
    case 51: return "E";
    default: return sLetter; } return "";
}

string ProcessLantanese(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertLantanese(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertMidani(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "i";
    case 1: return "z";
    case 2: return "n";
    case 3: return "a";
    case 4: return "a";
    case 5: return "k";
    case 6: return "d";
    case 7: return "h";
    case 8: return "i";
    case 9: return "a";
    case 10: return "m";
    case 11: return "r";
    case 12: return "a";
    case 13: return "b";
    case 14: return "d";
    case 15: return "e";
    case 16: return "s";
    case 17: return "d";
    case 18: return "e";
    case 19: return "i";
    case 20: return "r";
    case 21: return "n";
    case 22: return "t";
    case 23: return "e";
    case 24: return "S";
    case 25: return "C";
    case 26: return "A";
    case 27: return "A";
    case 28: return "N";
    case 29: return "L";
    case 30: return "D";
    case 31: return "I";
    case 32: return "S";
    case 33: return "M";
    case 34: return "'";
    case 35: return "S";
    case 36: return "Y";
    case 37: return "H";
    case 38: return "L";
    case 39: return "A";
    case 40: return "E";
    case 41: return "N  ";
    case 42: return "Rg";
    case 43: return "K";
    case 44: return "Gr";
    case 45: return "I";
    case 46: return "A";
    case 47: return "L";
    case 48: return "F";
    case 49: return "N";
    case 50: return "Y";
    case 51: return "U";
    default: return sLetter; } return "";
}

string ProcessMidani(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertMidani(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertMulhorandi(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "i";
    case 1: return "r";
    case 2: return "d";
    case 3: return "e";
    case 4: return "n";
    case 5: return "d";
    case 6: return "a";
    case 7: return "b";
    case 8: return "r";
    case 9: return "u";
    case 10: return "o";
    case 11: return "l";
    case 12: return "h";
    case 13: return "l";
    case 14: return "l";
    case 15: return "E";
    case 16: return "u";
    case 17: return "l";
    case 18: return "m";
    case 19: return "v";
    case 20: return " ";
    case 21: return "e";
    case 22: return "E";
    case 23: return "S";
    case 24: return "R";
    case 25: return "W";
    case 26: return "E";
    case 27: return "I";
    case 28: return "H";
    case 29: return "T";
    case 30: return "T";
    case 31: return "H";
    case 32: return "O";
    case 33: return "W";
    case 34: return "S";
    case 35: return "I";
    case 36: return "D";
    case 37: return "N";
    case 38: return "L";
    case 39: return "G";
    case 40: return "R";
    case 41: return "S";
    case 42: return "O";
    case 43: return "R";
    case 44: return "W";
    case 45: return "U";
    case 46: return "E";
    case 47: return "L";
    case 48: return "H";
    case 49: return "E";
    case 50: return "'";
    case 51: return "T";
    default: return sLetter; } return "";
}

string ProcessMulhorandi(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertMulhorandi(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertNexalan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "m";
    case 2: return "a";
    case 3: return "a";
    case 4: return "l";
    case 5: return "z";
    case 6: return "a";
    case 7: return "t";
    case 8: return "x";
    case 9: return "i";
    case 10: return "e";
    case 11: return "c";
    case 12: return "n";
    case 13: return "a";
    case 14: return "e";
    case 15: return "";
    case 16: return "n";
    case 17: return "";
    case 18: return "t";
    case 19: return "";
    case 20: return "e";
    case 21: return "";
    case 22: return "r";
    case 23: return "";
    case 24: return "P";
    case 25: return "";
    case 26: return "R";
    case 27: return "S";
    case 28: return "I";
    case 29: return "";
    case 30: return "S";
    case 31: return "";
    case 32: return "E";
    case 33: return " ";
    case 34: return "U";
    case 35: return "-";
    case 36: return "S";
    case 37: return "'";
    case 38: return "N";
    case 39: return "A";
    case 40: return "A";
    case 41: return "C";
    case 42: return "L";
    case 43: return "I";
    case 44: return "A";
    case 45: return "T";
    case 46: return "X";
    case 47: return "Z";
    case 48: return "E";
    case 49: return "A";
    case 50: return "N";
    case 51: return "M";
    default: return sLetter; } return "";
}

string ProcessNexalan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertNexalan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertOillusk(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "k";
    case 1: return "s";
    case 2: return "u";
    case 3: return "l";
    case 4: return "l";
    case 5: return "i";
    case 6: return "o";
    case 7: return "n";
    case 8: return "s";
    case 9: return "o";
    case 10: return "i";
    case 11: return "r";
    case 12: return "n";
    case 13: return "t";
    case 14: return "g";
    case 15: return "h";
    case 16: return "i";
    case 17: return "s";
    case 18: return "n";
    case 19: return "w";
    case 20: return "g";
    case 21: return "o";
    case 22: return "i";
    case 23: return "R";
    case 24: return "N";
    case 25: return "D";
    case 26: return "T";
    case 27: return "C";
    case 28: return "H";
    case 29: return "O";
    case 30: return "E";
    case 31: return "A";
    case 32: return "R";
    case 33: return "S";
    case 34: return "A";
    case 35: return "T";
    case 36: return "I";
    case 37: return "H";
    case 38: return "N";
    case 39: return "S";
    case 40: return "";
    case 41: return "I";
    case 42: return "'b";
    case 43: return "V";
    case 44: return "G";
    case 45: return "I";
    case 46: return "G";
    case 47: return "T";
    case 48: return "X";
    case 49: return "C";
    case 50: return " S";
    case 51: return "O";
    default: return sLetter; } return "";
}

string ProcessOillusk(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertOillusk(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertRashemi(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "i";
    case 1: return "r";
    case 2: return "m";
    case 3: return "a";
    case 4: return "e";
    case 5: return "s";
    case 6: return "h";
    case 7: return "h";
    case 8: return "s";
    case 9: return "e";
    case 10: return "a";
    case 11: return "m";
    case 12: return "r";
    case 13: return "Rawr";
    case 14: return "a";
    case 15: return "rarg";
    case 16: return "n";
    case 17: return "t";
    case 18: return "ej";
    case 19: return "e";
    case 20: return "x";
    case 21: return "d";
    case 22: return "cv";
    case 23: return "D";
    case 24: return "F";
    case 25: return "Y";
    case 26: return "I";
    case 27: return "B";
    case 28: return "S";
    case 29: return "E";
    case 30: return "H";
    case 31: return "A";
    case 32: return "F";
    case 33: return "R";
    case 34: return "L";
    case 35: return "P";
    case 36: return "A";
    case 37: return "U";
    case 38: return "M";
    case 39: return "N";
    case 40: return "M";
    case 41: return "K";
    case 42: return "A";
    case 43: return "E";
    case 44: return "B";
    case 45: return "L";
    case 46: return "T";
    case 47: return "E";
    case 48: return "N";
    case 49: return "P";
    case 50: return "A";
    case 51: return "H";
    default: return sLetter; } return "";
}

string ProcessRashemi(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertRashemi(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertRaumvira(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "a";
    case 1: return "t";
    case 2: return "r";
    case 3: return "h";
    case 4: return "i";
    case 5: return "e";
    case 6: return "v";
    case 7: return "s";
    case 8: return "m";
    case 9: return "k";
    case 10: return "u";
    case 11: return "t";
    case 12: return "a";
    case 13: return "h";
    case 14: return "r";
    case 15: return "a";
    case 16: return "";
    case 17: return "r";
    case 18: return "";
    case 19: return "r";
    case 20: return " ";
    case 21: return "i";
    case 22: return "S";
    case 23: return "sS";
    case 24: return "P";
    case 25: return "D";
    case 26: return "E";
    case 27: return "N";
    case 28: return "A";
    case 29: return "E";
    case 30: return "K";
    case 31: return "F";
    case 32: return "S";
    case 33: return "R";
    case 34: return "I";
    case 35: return "I";
    case 36: return "R";
    case 37: return "A";
    case 38: return "H";
    case 39: return "R";
    case 40: return "T";
    case 41: return "I";
    case 42: return "K";
    case 43: return "V";
    case 44: return "S";
    case 45: return "M";
    case 46: return "E";
    case 47: return "U";
    case 48: return "H";
    case 49: return "A";
    case 50: return "T";
    case 51: return "R";
    default: return sLetter; } return "";
}

string ProcessRaumvira(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertRaumvira(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertSerusan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "c";
    case 2: return "a";
    case 3: return "h";
    case 4: return "s";
    case 5: return "i";
    case 6: return "u";
    case 7: return "p";
    case 8: return "r";
    case 9: return "r";
    case 10: return "e";
    case 11: return "i";
    case 12: return "s";
    case 13: return "n";
    case 14: return "c";
    case 15: return "i";
    case 16: return "p";
    case 17: return "a";
    case 18: return "l";
    case 19: return "g";
    case 20: return "a";
    case 21: return "o";
    case 22: return "r";
    case 23: return "B";
    case 24: return "C";
    case 25: return "E";
    case 26: return "H";
    case 27: return "R";
    case 28: return "E";
    case 29: return "P";
    case 30: return "R";
    case 31: return "O";
    case 32: return "Sa";
    case 33: return "R";
    case 34: return "In";
    case 35: return "T";
    case 36: return "G";
    case 37: return "H";
    case 38: return "O";
    case 39: return "N";
    case 40: return "O";
    case 41: return "A";
    case 42: return "S";
    case 43: return "S";
    case 44: return "T";
    case 45: return "U";
    case 46: return "H";
    case 47: return "R";
    case 48: return "E";
    case 49: return "E";
    case 50: return "D";
    case 51: return "S";
    default: return sLetter; } return "";
}

string ProcessSerusan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertSerusan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertShaaran(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "s";
    case 2: return "a";
    case 3: return "e";
    case 4: return "r";
    case 5: return "s";
    case 6: return "a";
    case 7: return "p";
    case 8: return "a";
    case 9: return "e";
    case 10: return "h";
    case 11: return "c";
    case 12: return "s";
    case 13: return "h";
    case 14: return "t";
    case 15: return "s";
    case 16: return "h";
    case 17: return "c";
    case 18: return "e";
    case 19: return "h";
    case 20: return "s";
    case 21: return "o";
    case 22: return "h";
    case 23: return "L";
    case 24: return "A";
    case 25: return "Pa";
    case 26: return "R";
    case 27: return "A";
    case 28: return "R";
    case 29: return "L";
    case 30: return "M";
    case 31: return "I";
    case 32: return "A";
    case 33: return "I";
    case 34: return "E";
    case 35: return "Y";
    case 36: return "T";
    case 37: return "A";
    case 38: return "S";
    case 39: return "N";
    case 40: return "F";
    case 41: return "A";
    case 42: return "O";
    case 43: return "R";
    case 44: return "E";
    case 45: return "R";
    case 46: return "K";
    case 47: return "A";
    case 48: return "A";
    case 49: return "H";
    case 50: return "L";
    case 51: return "S";
    default: return sLetter; } return "";
}

string ProcessShaaran(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertShaaran(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertShou(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "u";
    case 1: return "e";
    case 2: return "o";
    case 3: return "m";
    case 4: return "h";
    case 5: return "p";
    case 6: return "s";
    case 7: return "o";
    case 8: return "d";
    case 9: return "r";
    case 10: return "r";
    case 11: return "e";
    case 12: return "a";
    case 13: return "r";
    case 14: return "c";
    case 15: return " ";
    case 16: return "o";
    case 17: return "j";
    case 18: return "n";
    case 19: return "w";
    case 20: return "i";
    case 21: return "nd";
    case 22: return "c";
    case 23: return "S";
    case 24: return "O";
    case 25: return "gh";
    case 26: return "B";
    case 27: return " ";
    case 28: return "A";
    case 29: return "'";
    case 30: return "G";
    case 31: return "A";
    case 32: return "N";
    case 33: return "V";
    case 34: return "A";
    case 35: return "L";
    case 36: return "R";
    case 37: return "A";
    case 38: return "U";
    case 39: return "Y";
    case 40: return "T";
    case 41: return "O";
    case 42: return "-";
    case 43: return "R";
    case 44: return "A";
    case 45: return "U";
    case 46: return "R";
    case 47: return "O";
    case 48: return "A";
    case 49: return "H";
    case 50: return "K";
    case 51: return "S";
    default: return sLetter; } return "";
}

string ProcessShou(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertShou(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertTalfiric(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "c";
    case 1: return "b";
    case 2: return "i";
    case 3: return "a";
    case 4: return "r";
    case 5: return "d";
    case 6: return "i";
    case 7: return "e";
    case 8: return "f";
    case 9: return "ho";
    case 10: return "l";
    case 11: return "w";
    case 12: return "a";
    case 13: return "e";
    case 14: return "t";
    case 15: return "s";
    case 16: return "a";
    case 17: return "t";
    case 18: return "l";
    case 19: return "e";
    case 20: return "c";
    case 21: return "r";
    case 22: return "u";
    case 23: return "N";
    case 24: return "M";
    case 25: return "He";
    case 26: return "P";
    case 27: return "A";
    case 28: return "O";
    case 29: return "R";
    case 30: return "W";
    case 31: return "T";
    case 32: return "D";
    case 33: return "L";
    case 34: return "E";
    case 35: return "A";
    case 36: return "R";
    case 37: return "C";
    case 38: return "N";
    case 39: return "I";
    case 40: return "D";
    case 41: return "R";
    case 42: return "S";
    case 43: return "E";
    case 44: return "";
    case 45: return "F";
    case 46: return "A";
    case 47: return "L";
    case 48: return "C";
    case 49: return "A";
    case 50: return "B";
    case 51: return "T";
    default: return sLetter; } return "";
}

string ProcessTalfiric(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertTalfiric(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertTashalan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "b";
    case 2: return "a";
    case 3: return "l";
    case 4: return "l";
    case 5: return "a";
    case 6: return "a";
    case 7: return "c";
    case 8: return "h";
    case 9: return "k";
    case 10: return "s";
    case 11: return "j";
    case 12: return "a";
    case 13: return "u";
    case 14: return "t";
    case 15: return "n";
    case 16: return "t";
    case 17: return "g";
    case 18: return "h";
    case 19: return "l";
    case 20: return "i";
    case 21: return "e";
    case 22: return "n";
    case 23: return "S";
    case 24: return "D";
    case 25: return "A";
    case 26: return "O";
    case 27: return "M";
    case 28: return "L";
    case 29: return "A";
    case 30: return "M";
    case 31: return "R";
    case 32: return "H";
    case 33: return "A";
    case 34: return "I";
    case 35: return "C";
    case 36: return "R";
    case 37: return "N";
    case 38: return "H";
    case 39: return "A";
    case 40: return "D";
    case 41: return "H";
    case 42: return "W";
    case 43: return "S";
    case 44: return "R";
    case 45: return "A";
    case 46: return "Ve";
    case 47: return "L";
    case 48: return "N";
    case 49: return "A";
    case 50: return "CC";
    case 51: return "T";
    default: return sLetter; } return "";
}

string ProcessTashalan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertTashalan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertTuigan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "p";
    case 2: return "a";
    case 3: return "e";
    case 4: return "g";
    case 5: return "o";
    case 6: return "i";
    case 7: return "n";
    case 8: return "u";
    case 9: return "s";
    case 10: return "t";
    case 11: return "w";
    case 12: return "tu";
    case 13: return "a";
    case 14: return "tin";
    case 15: return "r";
    case 16: return "ng";
    case 17: return "c";
    case 18: return "ti";
    case 19: return "h";
    case 20: return "ton";
    case 21: return "i";
    case 22: return "ng";
    case 23: return "E";
    case 24: return "Gyg";
    case 25: return "F";
    case 26: return "E";
    case 27: return "H";
    case 28: return "H";
    case 29: return "E";
    case 30: return "ET";
    case 31: return "H";
    case 32: return "S";
    case 33: return "T";
    case 34: return "D";
    case 35: return "R";
    case 36: return "N";
    case 37: return "O";
    case 38: return "A";
    case 39: return "F";
    case 40: return "L";
    case 41: return "N";
    case 42: return "E";
    case 43: return "A";
    case 44: return "D";
    case 45: return "G";
    case 46: return "R";
    case 47: return "I";
    case 48: return "O";
    case 49: return "U";
    case 50: return "H";
    case 51: return "T";
    default: return sLetter; } return "";
}

string ProcessTuigan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertTuigan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertTurmic(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "c";
    case 1: return "a";
    case 2: return "i";
    case 3: return "n";
    case 4: return "m";
    case 5: return "t";
    case 6: return "r";
    case 7: return "i";
    case 8: return "u";
    case 9: return "c";
    case 10: return "t";
    case 11: return "s";
    case 12: return "m";
    case 13: return "o";
    case 14: return "l";
    case 15: return "f";
    case 16: return "t";
    case 17: return "f";
    case 18: return "u";
    case 19: return "s";
    case 20: return "r";
    case 21: return "d";
    case 22: return "m";
    case 23: return "B";
    case 24: return "I";
    case 25: return "A";
    case 26: return "S";
    case 27: return "L";
    case 28: return "H";
    case 29: return "E";
    case 30: return "Le";
    case 31: return "F";
    case 32: return "A";
    case 33: return "F";
    case 34: return "D";
    case 35: return "O";
    case 36: return "D";
    case 37: return "R";
    case 38: return "N";
    case 39: return "P";
    case 40: return "A";
    case 41: return "C";
    case 42: return "R";
    case 43: return "I";
    case 44: return "Y";
    case 45: return "M";
    case 46: return "R";
    case 47: return "R";
    case 48: return "O";
    case 49: return "U";
    case 50: return "C";
    case 51: return "T";
    default: return sLetter; } return "";
}

string ProcessTurmic(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertTurmic(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertUluik(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "k";
    case 1: return "t";
    case 2: return "i";
    case 3: return "h";
    case 4: return "u";
    case 5: return "e";
    case 6: return "l";
    case 7: return "g";
    case 8: return "u";
    case 9: return "r";
    case 10: return "yu";
    case 11: return "e";
    case 12: return "x";
    case 13: return "a";
    case 14: return "se";
    case 15: return "t";
    case 16: return "te'";
    case 17: return "b";
    case 18: return "ym'";
    case 19: return "e";
    case 20: return "een";
    case 21: return "e";
    case 22: return "r";
    case 23: return "O";
    case 24: return "E";
    case 25: return "U";
    case 26: return "I";
    case 27: return "T";
    case 28: return "C";
    case 29: return "H";
    case 30: return "A";
    case 31: return "E";
    case 32: return "L";
    case 33: return "R";
    case 34: return "G";
    case 35: return "E";
    case 36: return "T";
    case 37: return "D";
    case 38: return "A";
    case 39: return "A";
    case 40: return "E";
    case 41: return "T";
    case 42: return "R";
    case 43: return "K";
    case 44: return "G";
    case 45: return "I";
    case 46: return "E";
    case 47: return "U";
    case 48: return "H";
    case 49: return "L";
    case 50: return "T";
    case 51: return "U";
    default: return sLetter; } return "";
}

string ProcessUluik(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertUluik(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertUntheric(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "c";
    case 1: return "u";
    case 2: return "i";
    case 3: return "n";
    case 4: return "r";
    case 5: return "t";
    case 6: return "e";
    case 7: return "h";
    case 8: return "h";
    case 9: return "e";
    case 10: return "t";
    case 11: return "r";
    case 12: return "n";
    case 13: return "d";
    case 14: return "u";
    case 15: return "e";
    case 16: return "a";
    case 17: return "t";
    case 18: return "l";
    case 19: return "h";
    case 20: return "e ";
    case 21: return "e";
    case 22: return "w";
    case 23: return "K";
    case 24: return "E";
    case 25: return "Sc";
    case 26: return "T";
    case 27: return "Ot";
    case 28: return "S";
    case 29: return "Ch";
    case 30: return "F";
    case 31: return "B";
    case 32: return "R";
    case 33: return "Oo";
    case 34: return "A";
    case 35: return "Ze";
    case 36: return "W";
    case 37: return "C";
    case 38: return "D";
    case 39: return "I";
    case 40: return "K";
    case 41: return "R";
    case 42: return "J";
    case 43: return "E";
    case 44: return "H";
    case 45: return "H";
    case 46: return "T";
    case 47: return "T";
    case 48: return "E";
    case 49: return "N";
    case 50: return "D";
    case 51: return "U";
    default: return sLetter; } return "";
}

string ProcessUntheric(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertUntheric(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertVaasan(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "n";
    case 1: return "t";
    case 2: return "a";
    case 3: return "h";
    case 4: return "s";
    case 5: return "e";
    case 6: return "a";
    case 7: return "t";
    case 8: return "a";
    case 9: return "o";
    case 10: return "v";
    case 11: return "r";
    case 12: return "h";
    case 13: return "t";
    case 14: return "i";
    case 15: return "u";
    case 16: return "g";
    case 17: return "r";
    case 18: return "h";
    case 19: return "e";
    case 20: return "i";
    case 21: return "d";
    case 22: return "c";
    case 23: return "L";
    case 24: return "E";
    case 25: return "A";
    case 26: return "G";
    case 27: return "N";
    case 28: return "O";
    case 29: return "D";
    case 30: return "O";
    case 31: return "S";
    case 32: return "G";
    case 33: return "San";
    case 34: return "L";
    case 35: return "Dwi";
    case 36: return "Y";
    case 37: return "Ch";
    case 38: return "M";
    case 39: return "Ti";
    case 40: return "O";
    case 41: return "N";
    case 42: return "O";
    case 43: return "A";
    case 44: return "G";
    case 45: return "A";
    case 46: return "L";
    case 47: return "S";
    case 48: return "Y";
    case 49: return "A";
    case 50: return "Oy";
    case 51: return "V";
    default: return sLetter; } return "";
}

string ProcessVaasan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertVaasan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertDruidic(string sLetter)
{
    if (GetStringLength(sLetter) > 1) sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
    switch (iTrans)
    {
    case 0: return "d";
    case 1: return "d";
    case 2: return "r";
    case 3: return "o";
    case 4: return "u";
    case 5: return "o";
    case 6: return "i";
    case 7: return "l";
    case 8: return "d";
    case 9: return "i";
    case 10: return "i";
    case 11: return "t";
    case 12: return "c";
    case 13: return "t";
    case 14: return "t";
    case 15: return "l";
    case 16: return "a";
    case 17: return "e";
    case 18: return "l";
    case 19: return "d";
    case 20: return "k";
    case 21: return "o";
    case 22: return "Wii";
    case 23: return "C";
    case 24: return "U";
    case 25: return "T";
    case 26: return "G";
    case 27: return "O";
    case 28: return "N";
    case 29: return "R";
    case 30: return "T";
    case 31: return "K";
    case 32: return "N";
    case 33: return "L";
    case 34: return "E";
    case 35: return "A";
    case 36: return "S";
    case 37: return "T";
    case 38: return "O";
    case 39: return "C";
    case 40: return "H";
    case 41: return "I";
    case 42: return "O";
    case 43: return "D";
    case 44: return "A";
    case 45: return "I";
    case 46: return "T";
    case 47: return "U";
    case 48: return "B";
    case 49: return "R";
    case 50: return "U";
    case 51: return "D";
    default: return sLetter; } return "";
}

string ProcessDruidic(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertDruidic(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertTroll(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "oo";
        case 1: return "g";
        case 2: return "lo";
        case 3: return "r";
        case 4: return "un";
        case 5: return "b";
        case 6: return "ag";
        case 7: return "aw";
        case 8: return "a";
        case 9: return "h";
        case 10: return "h";
        case 11: return "r";
        case 12: return "m";
        case 13: return "wa";
        case 14: return "a";
        case 15: return "ha";
        case 16: return "or";
        case 17: return "ug";
        case 18: return "ar";
        case 19: return "g";
        case 20: return "ee";
        case 21: return "m";
        case 22: return "ar";
        case 23: return "l";
        case 24: return "im";
        case 25: return "h";
        case 26: return "Oo";
        case 27: return "G";
        case 28: return "Lo";
        case 29: return "R";
        case 30: return "Un";
        case 31: return "B";
        case 32: return "Ag";
        case 33: return "Aw";
        case 34: return "A";
        case 35: return "H";
        case 36: return "H";
        case 37: return "R";
        case 38: return "M";
        case 39: return "Wa";
        case 40: return "A";
        case 41: return "Ha";
        case 42: return "Or";
        case 43: return "Ug";
        case 44: return "Ar";
        case 45: return "G";
        case 46: return "Ee";
        case 47: return "M";
        case 48: return "Ar";
        case 49: return "L";
        case 50: return "Im";
        case 51: return "H";
        default: return sLetter;
    }
    return "";
}

string ProcessTroll(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertTroll(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertThriKreen(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "'t'";
        case 1: return "cr";
        case 2: return "ch";
        case 3: return "r";
        case 4: return "'sk";
        case 5: return "sh";
        case 6: return "sk";
        case 7: return "ik";
        case 8: return "ss";
        case 9: return "rr";
        case 10: return "ck";
        case 11: return "rr";
        case 12: return "t";
        case 13: return "zz";
        case 14: return "ack";
        case 15: return "sp";
        case 16: return "kr";
        case 17: return "ix";
        case 18: return "k";
        case 19: return "p";
        case 20: return "'";
        case 21: return "v";
        case 22: return "chr";
        case 23: return "ta";
        case 24: return "w";
        case 25: return "z";
        case 26: return "'T'";
        case 27: return "Cr";
        case 28: return "Ch";
        case 29: return "R";
        case 30: return "'sk";
        case 31: return "Sh";
        case 32: return "Sk";
        case 33: return "Ik";
        case 34: return "Ss";
        case 35: return "Rr";
        case 36: return "Ck";
        case 37: return "Rr";
        case 38: return "T";
        case 39: return "Zz";
        case 40: return "Ack";
        case 41: return "Sp";
        case 42: return "Kr";
        case 43: return "Ix";
        case 44: return "K";
        case 45: return "P";
        case 46: return "'";
        case 47: return "V";
        case 48: return "Chr";
        case 49: return "Ta";
        case 50: return "W";
        case 51: return "Z";
        default: return sLetter;
    }
    return "";
}

string ProcessThriKreen(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertThriKreen(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertGrimlock(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "i";
        case 1: return "bu";
        case 2: return "c";
        case 3: return "ti";
        case 4: return "e";
        case 5: return "ch";
        case 6: return "j";
        case 7: return "";
        case 8: return "aa";
        case 9: return "t";
        case 10: return "C’k";
        case 11: return "k’";
        case 12: return "ti";
        case 13: return "K’k";
        case 14: return "eo";
        case 15: return "ch";
        case 16: return "";
        case 17: return "r";
        case 18: return "k";
        case 19: return "kk";
        case 20: return "oo";
        case 21: return "cl";
        case 22: return "q";
        case 23: return "z";
        case 24: return "e";
        case 25: return "z";
        case 26: return "I";
        case 27: return "Bu";
        case 28: return "C";
        case 29: return "Ti";
        case 30: return "E";
        case 31: return "Ch";
        case 32: return "J";
        case 33: return "";
        case 34: return "Aa";
        case 35: return "T";
        case 36: return "Ck";
        case 37: return "K’";
        case 38: return "Ti";
        case 39: return "Kk’";
        case 40: return "Eo";
        case 41: return "Ch";
        case 42: return "";
        case 43: return "R";
        case 44: return "K";
        case 45: return "Kk";
        case 46: return "Oo";
        case 47: return "Cl";
        case 48: return "Q";
        case 49: return "Z";
        case 50: return "E";
        case 51: return "Z";
        default: return sLetter;
    }
    return "";
}

string ProcessGrimlock(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertGrimlock(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertKuoToan(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "u";
        case 1: return "bo";
        case 2: return "ch";
        case 3: return "b";
        case 4: return "o";
        case 5: return "cr";
        case 6: return "go";
        case 7: return "u";
        case 8: return "oa";
        case 9: return "urg";
        case 10: return "cro";
        case 11: return "l";
        case 12: return "t";
        case 13: return "a";
        case 14: return "a";
        case 15: return "po";
        case 16: return "kr";
        case 17: return "ak";
        case 18: return "g";
        case 19: return "k";
        case 20: return "ou";
        case 21: return "v";
        case 22: return "b";
        case 23: return "ta";
        case 24: return "ku";
        case 25: return "z";
        case 26: return "U";
        case 27: return "Bo";
        case 28: return "Ch";
        case 29: return "B";
        case 30: return "O";
        case 31: return "Cr";
        case 32: return "Go";
        case 33: return "U";
        case 34: return "Oa";
        case 35: return "Urg";
        case 36: return "Cro";
        case 37: return "L";
        case 38: return "T";
        case 39: return "A";
        case 40: return "A";
        case 41: return "Po";
        case 42: return "Kr";
        case 43: return "Ak";
        case 44: return "G";
        case 45: return "K";
        case 46: return "Ou";
        case 47: return "V";
        case 48: return "B";
        case 49: return "Ta";
        case 50: return "Ku";
        case 51: return "Z";
        default: return sLetter;
    }
    return "";
}

string ProcessKuoToan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertKuoToan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertMinotaur(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "a";
        case 1: return "ai";
        case 2: return "s";
        case 3: return "h";
        case 4: return "i";
        case 5: return "t";
        case 6: return "b";
        case 7: return "f";
        case 8: return "u";
        case 9: return "r";
        case 10: return "k";
        case 11: return "ug";
        case 12: return "sh";
        case 13: return "l";
        case 14: return "gh";
        case 15: return "y";
        case 16: return "z";
        case 17: return "ra";
        case 18: return "mo";
        case 19: return "n";
        case 20: return "";
        case 21: return "un";
        case 22: return "oo";
        case 23: return "";
        case 24: return "la";
        case 25: return "dz";
        case 26: return "A";
        case 27: return "Ai";
        case 28: return "S";
        case 29: return "H";
        case 30: return "I";
        case 31: return "T";
        case 32: return "B";
        case 33: return "F";
        case 34: return "U";
        case 35: return "R";
        case 36: return "K";
        case 37: return "Ug";
        case 38: return "Sh";
        case 39: return "L";
        case 40: return "Gh";
        case 41: return "Y";
        case 42: return "Z";
        case 43: return "Ra";
        case 44: return "Mo";
        case 45: return "N";
        case 46: return "'";
        case 47: return "Un";
        case 48: return "Oo";
        case 49: return "";
        case 50: return "La";
        case 51: return "Dz";
        default: return sLetter;
    }
    return "";
}

string ProcessMinotaur(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertMinotaur(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertRakshasa(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "o";
        case 1: return "p";
        case 2: return "s";
        case 3: return "";
        case 4: return "ea";
        case 5: return "m";
        case 6: return "r'";
        case 7: return "au";
        case 8: return "ui";
        case 9: return "";
        case 10: return "g";
        case 11: return "r";
        case 12: return "h";
        case 13: return "l";
        case 14: return "a";
        case 15: return "p";
        case 16: return "";
        case 17: return "gr";
        case 18: return "w";
        case 19: return "r";
        case 20: return "ou";
        case 21: return "u";
        case 22: return "ge";
        case 23: return "rs";
        case 24: return "e";
        case 25: return "ss";
        case 26: return "O";
        case 27: return "P";
        case 28: return "S";
        case 29: return "'";
        case 30: return "Ea";
        case 31: return "M";
        case 32: return "Rr";
        case 33: return "Au";
        case 34: return "Oe";
        case 35: return "";
        case 36: return "G";
        case 37: return "R";
        case 38: return "H";
        case 39: return "L";
        case 40: return "A";
        case 41: return "P";
        case 42: return "";
        case 43: return "Gr";
        case 44: return "W";
        case 45: return "R";
        case 46: return "Ow";
        case 47: return "U";
        case 48: return "Ge";
        case 49: return "Rs";
        case 50: return "E";
        case 51: return "Ss";
        default: return sLetter;
    }
    return "";
}

string ProcessRakshasa(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertRakshasa(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertStinger(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "as";
        case 1: return "bi";
        case 2: return "";
        case 3: return "";
        case 4: return "iss";
        case 5: return "en";
        case 6: return "ga";
        case 7: return "h";
        case 8: return "iss";
        case 9: return "";
        case 10: return "ka";
        case 11: return "l";
        case 12: return "mm";
        case 13: return "nn";
        case 14: return "os";
        case 15: return "pe";
        case 16: return "ke";
        case 17: return "";
        case 18: return "ess";
        case 19: return "T";
        case 20: return "us";
        case 21: return "v";
        case 22: return "";
        case 23: return "z";
        case 24: return "yss";
        case 25: return "z";
        case 26: return "As";
        case 27: return "Bi";
        case 28: return "";
        case 29: return "";
        case 30: return "Iss";
        case 31: return "En";
        case 32: return "Ga";
        case 33: return "H";
        case 34: return "Iss";
        case 35: return "";
        case 36: return "Ka";
        case 37: return "L";
        case 38: return "Mm";
        case 39: return "Nn";
        case 40: return "Os";
        case 41: return "Pe";
        case 42: return "Ke";
        case 43: return "";
        case 44: return "Ess";
        case 45: return "TT";
        case 46: return "us";
        case 47: return "V";
        case 48: return "";
        case 49: return "Z";
        case 50: return "Yss";
        case 51: return "Z";
        default: return sLetter;
    }
    return "";
}

string ProcessStinger(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertStinger(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertLizardMan(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "sa";
        case 1: return "pr";
        case 2: return "k";
        case 3: return "st";
        case 4: return "ey";
        case 5: return "v";
        case 6: return "a";
        case 7: return "‘";
        case 8: return "i";
        case 9: return "huss";
        case 10: return "ct";
        case 11: return "d";
        case 12: return "vr";
        case 13: return "et";
        case 14: return "ee";
        case 15: return "dr";
        case 16: return "ki";
        case 17: return "rr";
        case 18: return "sz";
        case 19: return "sh";
        case 20: return "i";
        case 21: return "r";
        case 22: return "rr";
        case 23: return "";
        case 24: return "k";
        case 25: return "ss";
        case 26: return "Za";
        case 27: return "Pr";
        case 28: return "Kz";
        case 29: return "St";
        case 30: return "Hr";
        case 31: return "Vs";
        case 32: return "Asz";
        case 33: return "S";
        case 34: return "Ye";
        case 35: return "Vr";
        case 36: return "Gi’";
        case 37: return "D";
        case 38: return "Vr";
        case 39: return "Te";
        case 40: return "Sur";
        case 41: return "Dr";
        case 42: return "Ki";
        case 43: return "Rr";
        case 44: return "Sz";
        case 45: return "Ba’";
        case 46: return "Ou";
        case 47: return "Fr";
        case 48: return "Huo";
        case 49: return "";
        case 50: return "Ee’";
        case 51: return "Ss";
        default: return sLetter;
    }
    return "";
}

string ProcessLizardMan(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertLizardMan(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertIllithid(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "u";
        case 1: return "b";
        case 2: return "wo";
        case 3: return "ma";
        case 4: return "ga";
        case 5: return "wah";
        case 6: return "um";
        case 7: return "wa";
        case 8: return "aba";
        case 9: return "gu";
        case 10: return "bah";
        case 11: return "lo";
        case 12: return "m";
        case 13: return "ba";
        case 14: return "ub";
        case 15: return "ru";
        case 16: return "u";
        case 17: return "m";
        case 18: return "mur";
        case 19: return "g";
        case 20: return "bu";
        case 21: return "g";
        case 22: return "b";
        case 23: return "g";
        case 24: return "y";
        case 25: return "g";
        case 26: return "U";
        case 27: return "B";
        case 28: return "Wo";
        case 29: return "Ma";
        case 30: return "Ga";
        case 31: return "Wah";
        case 32: return "Um";
        case 33: return "Wa";
        case 34: return "Aba";
        case 35: return "Gu";
        case 36: return "Bah";
        case 37: return "Ol";
        case 38: return "M";
        case 39: return "Ba";
        case 40: return "Ub";
        case 41: return "Ru";
        case 42: return "U";
        case 43: return "M";
        case 44: return "Mur";
        case 45: return "G";
        case 46: return "Bu";
        case 47: return "G";
        case 48: return "B";
        case 49: return "G";
        case 50: return "Y";
        case 51: return "G";
        default: return sLetter;
    }
    return "";
}

string ProcessIllithid(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertIllithid(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertHobgoblin(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "o";
        case 1: return "l";
        case 2: return "t";
        case 3: return "da";
        case 4: return "a";
        case 5: return "v";
        case 6: return "b";
        case 7: return "r";
        case 8: return "a";
        case 9: return "f";
        case 10: return "kk";
        case 11: return "n";
        case 12: return "m";
        case 13: return "r";
        case 14: return "o";
        case 15: return "b";
        case 16: return "z";
        case 17: return "t";
        case 18: return "z";
        case 19: return "k";
        case 20: return "a";
        case 21: return "j";
        case 22: return "kka";
        case 23: return "ck";
        case 24: return "ga";
        case 25: return "ch";
        case 26: return "I";
        case 27: return "L";
        case 28: return "T";
        case 29: return "Da";
        case 30: return "A";
        case 31: return "V";
        case 32: return "B";
        case 33: return "R";
        case 34: return "Ae";
        case 35: return "F";
        case 36: return "Kr";
        case 37: return "N";
        case 38: return "M";
        case 39: return "G";
        case 40: return "O";
        case 41: return "B";
        case 42: return "Z";
        case 43: return "L";
        case 44: return "Z";
        case 45: return "K";
        case 46: return "E";
        case 47: return "J";
        case 48: return "Ch";
        case 49: return "Cho";
        case 50: return "V";
        case 51: return "Ch";
        default: return sLetter;
    }
    return "";
}

string ProcessHobgoblin(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertHobgoblin(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertDuergar(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "ao";
        case 1: return "ba";
        case 2: return "ch";
        case 3: return "ed";
        case 4: return "eo";
        case 5: return "ph";
        case 6: return "gah";
        case 7: return "oo";
        case 8: return "e";
        case 9: return "je";
        case 10: return "poo";
        case 11: return "";
        case 12: return "ke";
        case 13: return "qe";
        case 14: return "";
        case 15: return "pe";
        case 16: return "h";
        case 17: return "rag";
        case 18: return "";
        case 19: return "au";
        case 20: return "";
        case 21: return "m";
        case 22: return "u";
        case 23: return "ke";
        case 24: return "ee";
        case 25: return "op";
        case 26: return "Ao";
        case 27: return "Ba";
        case 28: return "Ch";
        case 29: return "Ed";
        case 30: return "Eo";
        case 31: return "Ph";
        case 32: return "Gah";
        case 33: return "Oo";
        case 34: return "E";
        case 35: return "Je";
        case 36: return "Poo";
        case 37: return "";
        case 38: return "Ke";
        case 39: return "Qe";
        case 40: return "";
        case 41: return "Pe";
        case 42: return "H";
        case 43: return "Rag";
        case 44: return "";
        case 45: return "Au";
        case 46: return "";
        case 47: return "M";
        case 48: return "U";
        case 49: return "Ke";
        case 50: return "Ee";
        case 51: return "Op";
        default: return sLetter;
    }
    return "";
}

string ProcessDuergar(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertDuergar(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertBugBear(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "aa";
        case 1: return "bom";
        case 2: return "hh";
        case 3: return "doh";
        case 4: return "eh";
        case 5: return "fuu";
        case 6: return "hh";
        case 7: return "hm";
        case 8: return "hh";
        case 9: return "ju";
        case 10: return "hh";
        case 11: return "loo";
        case 12: return "m";
        case 13: return "m";
        case 14: return "oo";
        case 15: return "puh";
        case 16: return "hh";
        case 17: return "rr";
        case 18: return "hh";
        case 19: return "hh";
        case 20: return "uun";
        case 21: return "hh";
        case 22: return "wah";
        case 23: return "hh";
        case 24: return "yum";
        case 25: return "hh";
        case 26: return "Hma";
        case 27: return "Hom";
        case 28: return "Hh";
        case 29: return "Hoh";
        case 30: return "Heh";
        case 31: return "Hu";
        case 32: return "Hh";
        case 33: return "Hm";
        case 34: return "Hh";
        case 35: return "Hhu";
        case 36: return "Hh";
        case 37: return "Loo";
        case 38: return "Hm";
        case 39: return "H";
        case 40: return "Hoo";
        case 41: return "Huh";
        case 42: return "Hh";
        case 43: return "Hrr";
        case 44: return "Hh";
        case 45: return "Hh";
        case 46: return "Hun";
        case 47: return "Hh";
        case 48: return "Hah";
        case 49: return "Hh";
        case 50: return "Hum";
        case 51: return "Hh";
        default: return sLetter;
    }
    return "";
}

string ProcessBugBear(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertBugBear(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertGithzerai(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "e";
        case 1: return "y";
        case 2: return "";
        case 3: return "b";
        case 4: return "i'";
        case 5: return "";
        case 6: return "d";
        case 7: return "g";
        case 8: return "o";
        case 9: return "";
        case 10: return "";
        case 11: return "h";
        case 12: return "mm";
        case 13: return "ny";
        case 14: return "a'";
        case 15: return "";
        case 16: return "l";
        case 17: return "";
        case 18: return "";
        case 19: return "";
        case 20: return "";
        case 21: return "r";
        case 22: return "";
        case 23: return "";
        case 24: return "w";
        case 25: return "";
        case 26: return "E";
        case 27: return "Y";
        case 28: return "";
        case 29: return "B";
        case 30: return "I";
        case 31: return "";
        case 32: return "D";
        case 33: return "G";
        case 34: return "O";
        case 35: return "";
        case 36: return "";
        case 37: return "H";
        case 38: return "M";
        case 39: return "N";
        case 40: return "A";
        case 41: return "";
        case 42: return "L";
        case 43: return "";
        case 44: return "";
        case 45: return "";
        case 46: return "";
        case 47: return "R";
        case 48: return "";
        case 49: return "";
        case 50: return "W";
        case 51: return "";
        default: return sLetter;
    }
    return "";
}

string ProcessGithzerai(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertGithzerai(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertKorred(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "eu";
        case 1: return "r";
        case 2: return "k";
        case 3: return "c";
        case 4: return "o";
        case 5: return "g";
        case 6: return "j";
        case 7: return "ch";
        case 8: return "ei";
        case 9: return "gu";
        case 10: return "chk";
        case 11: return "f";
        case 12: return "n";
        case 13: return "m";
        case 14: return "ue";
        case 15: return "q";
        case 16: return "k";
        case 17: return "g";
        case 18: return "z";
        case 19: return "d";
        case 20: return "i";
        case 21: return "x";
        case 22: return "u";
        case 23: return "l ";
        case 24: return "e";
        case 25: return "q";
        case 26: return "Eu";
        case 27: return "R";
        case 28: return "K";
        case 29: return "C";
        case 30: return "O";
        case 31: return "G";
        case 32: return "J";
        case 33: return "Ch";
        case 34: return "Ei";
        case 35: return "Gu";
        case 36: return "Chk";
        case 37: return "F";
        case 38: return "N";
        case 39: return "M";
        case 40: return "Ue";
        case 41: return "Q";
        case 42: return "K";
        case 43: return "G";
        case 44: return "Z";
        case 45: return "D";
        case 46: return "I";
        case 47: return "X";
        case 48: return "U";
        case 49: return "L ";
        case 50: return "E";
        case 51: return "Q";
        default: return sLetter;
    }
    return "";
}

string ProcessKorred(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertKorred(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertSahaguin(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "z";
        case 1: return "";
        case 2: return "h";
        case 3: return "e";
        case 4: return "u";
        case 5: return "'";
        case 6: return "h";
        case 7: return "'";
        case 8: return "oho'";
        case 9: return "g";
        case 10: return "k'k'";
        case 11: return "s";
        case 12: return "s";
        case 13: return "h";
        case 14: return "yfa'";
        case 15: return "-";
        case 16: return "xz";
        case 17: return "av";
        case 18: return "m";
        case 19: return "k";
        case 20: return "w";
        case 21: return "'Bha";
        case 22: return "yy";
        case 23: return "cras";
        case 24: return "ee";
        case 25: return "Mys";
        case 26: return "S";
        case 27: return "S'";
        case 28: return "Q";
        case 29: return "Ge";
        case 30: return "T";
        case 31: return "";
        case 32: return "Yi";
        case 33: return "-";
        case 34: return "Y";
        case 35: return "H'i";
        case 36: return "T";
        case 37: return "Tra";
        case 38: return "Ii";
        case 39: return "I";
        case 40: return "";
        case 41: return "";
        case 42: return "W";
        case 43: return "Hss'";
        case 44: return "M";
        case 45: return "Kh";
        case 46: return "Oo";
        case 47: return "Bh";
        case 48: return "'us";
        case 49: return "Eaya";
        case 50: return "Fhr";
        case 51: return "Wt";
        default: return sLetter;
    }
    return "";
}

string ProcessSahaguin(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertSahaguin(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertYuanTi(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "au";
        case 1: return "c";
        case 2: return "c";
        case 3: return "sp";
        case 4: return "i";
        case 5: return "ish";
        case 6: return "ash";
        case 7: return "s";
        case 8: return "ou";
        case 9: return "hi";
        case 10: return "'s";
        case 11: return "si";
        case 12: return "li";
        case 13: return "ah";
        case 14: return "a";
        case 15: return "s";
        case 16: return "l";
        case 17: return "h";
        case 18: return "ss";
        case 19: return "ti";
        case 20: return "i";
        case 21: return "v";
        case 22: return "h";
        case 23: return "ch";
        case 24: return "y";
        case 25: return "y";
        case 26: return "Au";
        case 27: return "C";
        case 28: return "C";
        case 29: return "Sp";
        case 30: return "I";
        case 31: return "Ish";
        case 32: return "Ash";
        case 33: return "S";
        case 34: return "Iss";
        case 35: return "Hi";
        case 36: return "S'";
        case 37: return "Si";
        case 38: return "Li";
        case 39: return "Ah";
        case 40: return "A";
        case 41: return "S";
        case 42: return "L";
        case 43: return "H";
        case 44: return "Ss";
        case 45: return "Ti";
        case 46: return "I";
        case 47: return "V";
        case 48: return "H";
        case 49: return "Ch";
        case 50: return "Y";
        case 51: return "Y";
        default: return sLetter;
    }
    return "";
}

string ProcessYuanTi(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertYuanTi(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertPixie(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "eg";
        case 1: return "o";
        case 2: return "s";
        case 3: return "";
        case 4: return "it";
        case 5: return "th";
        case 6: return "oo";
        case 7: return "n";
        case 8: return "e";
        case 9: return "ta";
        case 10: return "";
        case 11: return "an";
        case 12: return "a";
        case 13: return "ei";
        case 14: return "i";
        case 15: return "k";
        case 16: return "ca";
        case 17: return "t";
        case 18: return "l";
        case 19: return "m";
        case 20: return "ya";
        case 21: return "d";
        case 22: return "v";
        case 23: return "p";
        case 24: return "ni";
        case 25: return "z";
        case 26: return "Eg";
        case 27: return "O";
        case 28: return "S";
        case 29: return "'";
        case 30: return "It";
        case 31: return "Th";
        case 32: return "Oo";
        case 33: return "N";
        case 34: return "E";
        case 35: return "Ta";
        case 36: return "'";
        case 37: return "An";
        case 38: return "A";
        case 39: return "Ei";
        case 40: return "I";
        case 41: return "K";
        case 42: return "Ca";
        case 43: return "T";
        case 44: return "L";
        case 45: return "M";
        case 46: return "Ya";
        case 47: return "D";
        case 48: return "V";
        case 49: return "P";
        case 50: return "Ni";
        case 51: return "Z";
        default: return sLetter;
    }
    return "";
}

string ProcessPixie(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertPixie(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertHengeyokai(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "i";
        case 1: return "ja";
        case 2: return "ka";
        case 3: return "ta";
        case 4: return "o";
        case 5: return "xa";
        case 6: return "je";
        case 7: return "ke";
        case 8: return "u";
        case 9: return "te";
        case 10: return "xe";
        case 11: return "ji";
        case 12: return "ki";
        case 13: return "ti";
        case 14: return "a";
        case 15: return "xi";
        case 16: return " ";
        case 17: return "xo";
        case 18: return "ko";
        case 19: return "to";
        case 20: return "e";
        case 21: return "jo";
        case 22: return "ju";
        case 23: return "ku";
        case 24: return "tu";
        case 25: return "xu";
        case 26: return "I";
        case 27: return "Ja";
        case 28: return "Ka";
        case 29: return "Ta";
        case 30: return "O";
        case 31: return "Xa";
        case 32: return "Je";
        case 33: return "Ke";
        case 34: return "U";
        case 35: return "Te";
        case 36: return "Xe";
        case 37: return "Ji";
        case 38: return "KiI";
        case 39: return "Ti";
        case 40: return "A";
        case 41: return "Xi";
        case 42: return "";
        case 43: return "Xo";
        case 44: return "Ko";
        case 45: return "To";
        case 46: return "E";
        case 47: return "Jo";
        case 48: return "Ju";
        case 49: return "Ku";
        case 50: return "Tu";
        case 51: return "Xu";
        default: return sLetter;
    }
    return "";
}

string ProcessHengeyokai(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertHengeyokai(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertSvirfneblin(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "y";
        case 1: return "pa";
        case 2: return "le";
        case 3: return "ti";
        case 4: return "a";
        case 5: return "r";
        case 6: return "ka";
        case 7: return "v";
        case 8: return "e";
        case 9: return "zha";
        case 10: return "ga";
        case 11: return "ma";
        case 12: return "s";
        case 13: return "ha";
        case 14: return "u";
        case 15: return "bi";
        case 16: return "x";
        case 17: return "na";
        case 18: return "c";
        case 19: return "da";
        case 20: return "i";
        case 21: return "j";
        case 22: return "f";
        case 23: return "q";
        case 24: return "o";
        case 25: return "w";
        case 26: return "Y";
        case 27: return "Pa";
        case 28: return "Le";
        case 29: return "Ti";
        case 30: return "A";
        case 31: return "R";
        case 32: return "Ka";
        case 33: return "V";
        case 34: return "E";
        case 35: return "Zha";
        case 36: return "Ga";
        case 37: return "Ma";
        case 38: return "S";
        case 39: return "Ha";
        case 40: return "U";
        case 41: return "Bi";
        case 42: return "X";
        case 43: return "Na";
        case 44: return "C";
        case 45: return "Da";
        case 46: return "I";
        case 47: return "J";
        case 48: return "F";
        case 49: return "Q";
        case 50: return "O";
        case 51: return "W";
        default: return sLetter;
    }
    return "";
}

string ProcessSvirfneblin(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertSvirfneblin(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertHighShou(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "wa";
        case 1: return "bu";
        case 2: return "chi";
        case 3: return "do";
        case 4: return "";
        case 5: return "fi";
        case 6: return "";
        case 7: return "";
        case 8: return "wi";
        case 9: return "";
        case 10: return "";
        case 11: return "lei";
        case 12: return "mi";
        case 13: return "no";
        case 14: return "";
        case 15: return "pe";
        case 16: return "";
        case 17: return "";
        case 18: return "cho";
        case 19: return "tu";
        case 20: return "ng";
        case 21: return "on";
        case 22: return "wo";
        case 23: return "in";
        case 24: return "ya";
        case 25: return "";
        case 26: return "Wa";
        case 27: return "Bu";
        case 28: return "Chi";
        case 29: return "Do";
        case 30: return "";
        case 31: return "Fi";
        case 32: return "";
        case 33: return "";
        case 34: return "Wi";
        case 35: return "";
        case 36: return "";
        case 37: return "Lei";
        case 38: return "Mi";
        case 39: return "No";
        case 40: return "";
        case 41: return "Pe";
        case 42: return "";
        case 43: return "";
        case 44: return "Cho";
        case 45: return "Tu";
        case 46: return "Ng";
        case 47: return "On";
        case 48: return "Wo";
        case 49: return "In";
        case 50: return "Ya";
        case 51: return "";
        default: return sLetter;
    }
    return "";
}

string ProcessHighShou(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertHighShou(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertAverial(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "ii";
        case 1: return "q";
        case 2: return "kx";
        case 3: return "tt";
        case 4: return "ii";
        case 5: return "‘";
        case 6: return "";
        case 7: return "ll";
        case 8: return "ui";
        case 9: return "yii";
        case 10: return "‘";
        case 11: return "li";
        case 12: return "my";
        case 13: return "no";
        case 14: return "ia";
        case 15: return "piie";
        case 16: return "";
        case 17: return "‘";
        case 18: return "ii";
        case 19: return "to";
        case 20: return "uii";
        case 21: return "ti";
        case 22: return "tsi";
        case 23: return "ix";
        case 24: return "io";
        case 25: return "";
        case 26: return "Ia";
        case 27: return "Bo";
        case 28: return "Cii";
        case 29: return "Io";
        case 30: return "Iee ";
        case 31: return "Shi";
        case 32: return "Xi";
        case 33: return "A";
        case 34: return "Wi";
        case 35: return "Fi";
        case 36: return "Rx";
        case 37: return "Li";
        case 38: return "Mrr";
        case 39: return "No";
        case 40: return "Oio";
        case 41: return "Prii";
        case 42: return "";
        case 43: return "Rs";
        case 44: return "Sio";
        case 45: return "Tr";
        case 46: return "Iu";
        case 47: return "Av";
        case 48: return "Va";
        case 49: return "Ti";
        case 50: return "Ya";
        case 51: return "Ziu";
        default: return sLetter;
    }
    return "";
}

string ProcessAverial(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertAverial(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertKobold(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "u";
        case 1: return "";
        case 2: return "r";
        case 3: return "s";
        case 4: return "uk";
        case 5: return "y";
        case 6: return "k";
        case 7: return "r";
        case 8: return "i";
        case 9: return "t";
        case 10: return "h";
        case 11: return "x";
        case 12: return "";
        case 13: return "g";
        case 14: return "o";
        case 15: return "p";
        case 16: return "";
        case 17: return "l";
        case 18: return "n";
        case 19: return "g";
        case 20: return "u";
        case 21: return "h";
        case 22: return "a";
        case 23: return "gr";
        case 24: return "i";
        case 25: return "m";
        case 26: return "U";
        case 27: return "";
        case 28: return "R";
        case 29: return "S";
        case 30: return "U";
        case 31: return "Y";
        case 32: return "K";
        case 33: return "R";
        case 34: return "I";
        case 35: return "T";
        case 36: return "H";
        case 37: return "X";
        case 38: return "";
        case 39: return "G";
        case 40: return "O";
        case 41: return "P";
        case 42: return "";
        case 43: return "L";
        case 44: return "N";
        case 45: return "G";
        case 46: return "U";
        case 47: return "H";
        case 48: return "A";
        case 49: return "Gr";
        case 50: return "I";
        case 51: return "M";
        default: return sLetter;
    }
    return "";
}

string ProcessKobold(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertKobold(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertOgre(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "u";
        case 1: return "ga";
        case 2: return "me";
        case 3: return "bi";
        case 4: return "a";
        case 5: return "do";
        case 6: return "gu";
        case 7: return "ma";
        case 8: return "e";
        case 9: return "be";
        case 10: return "di";
        case 11: return "go";
        case 12: return "mu";
        case 13: return "ba";
        case 14: return "i";
        case 15: return "de";
        case 16: return "gi";
        case 17: return "mo";
        case 18: return "bu";
        case 19: return "da";
        case 20: return "o";
        case 21: return "ge";
        case 22: return "mi";
        case 23: return "bo";
        case 24: return "du";
        case 25: return "ga";
        case 26: return "U";
        case 27: return "Ga";
        case 28: return "Me";
        case 29: return "Bi";
        case 30: return "A";
        case 31: return "Do";
        case 32: return "Gu";
        case 33: return "Ma";
        case 34: return "E";
        case 35: return "Be";
        case 36: return "Di";
        case 37: return "Go";
        case 38: return "Mu";
        case 39: return "Ba";
        case 40: return "I";
        case 41: return "De";
        case 42: return "Gi";
        case 43: return "Mo";
        case 44: return "Bu";
        case 45: return "Da";
        case 46: return "O";
        case 47: return "Ge";
        case 48: return "Mi";
        case 49: return "Bo";
        case 50: return "Du";
        case 51: return "Ga";
        default: return sLetter;
    }
    return "";
}

string ProcessOgre(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertOgre(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}


string ConvertDrow(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "il";
    case 26: return "Il";
    case 1: return "f";
    case 2: return "st";
    case 28: return "St";
    case 3: return "w";
    case 4: return "a";
    case 5: return "o";
    case 6: return "v";
    case 7: return "ir";
    case 33: return "Ir";
    case 8: return "e";
    case 9: return "vi";
    case 35: return "Vi";
    case 10: return "go";
    case 11: return "c";
    case 12: return "li";
    case 13: return "l";
    case 14: return "e";
    case 15: return "ty";
    case 41: return "Ty";
    case 16: return "r";
    case 17: return "m";
    case 18: return "la";
    case 44: return "La";
    case 19: return "an";
    case 45: return "An";
    case 20: return "y";
    case 21: return "el";
    case 47: return "El";
    case 22: return "ky";
    case 48: return "Ky";
    case 23: return "'";
    case 24: return "a";
    case 25: return "p'";
    case 27: return "F";
    case 29: return "W";
    case 30: return "A";
    case 31: return "O";
    case 32: return "V";
    case 34: return "E";
    case 36: return "Go";
    case 37: return "C";
    case 38: return "Li";
    case 39: return "L";
    case 40: return "E";
    case 42: return "R";
    case 43: return "M";
    case 46: return "Y";
    case 49: return "'";
    case 50: return "A";
    case 51: return "P'";

    default: return sLetter; } return "";
}

string ProcessDrow(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertDrow(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertInfernal(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "o";
    case 1: return "c";
    case 2: return "r";
    case 3: return "j";
    case 4: return "a";
    case 5: return "v";
    case 6: return "k";
    case 7: return "r";
    case 8: return "y";
    case 9: return "z";
    case 10: return "g";
    case 11: return "m";
    case 12: return "z";
    case 13: return "r";
    case 14: return "y";
    case 15: return "k";
    case 16: return "r";
    case 17: return "n";
    case 18: return "k";
    case 19: return "d";
    case 20: return "'";
    case 21: return "r";
    case 22: return "'";
    case 23: return "k";
    case 24: return "i";
    case 25: return "g";
    case 26: return "O";
    case 27: return "C";
    case 28: return "R";
    case 29: return "J";
    case 30: return "A";
    case 31: return "V";
    case 32: return "K";
    case 33: return "R";
    case 34: return "Y";
    case 35: return "Z";
    case 36: return "G";
    case 37: return "M";
    case 38: return "Z";
    case 39: return "R";
    case 40: return "Y";
    case 41: return "K";
    case 42: return "R";
    case 43: return "N";
    case 44: return "K";
    case 45: return "D";
    case 46: return "'";
    case 47: return "R";
    case 48: return "'";
    case 49: return "K";
    case 50: return "I";
    case 51: return "G";
    default: return sLetter;
    }
    return "";
}//end ConvertInfernal

string ProcessInfernal(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertInfernal(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertAbyssal(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 27: return "N";
    case 28: return "M";
    case 29: return "G";
    case 30: return "A";
    case 31: return "K";
    case 32: return "S";
    case 33: return "D";
    case 35: return "H";
    case 36: return "B";
    case 37: return "L";
    case 38: return "P";
    case 39: return "T";
    case 40: return "E";
    case 41: return "B";
    case 43: return "N";
    case 44: return "M";
    case 45: return "G";
    case 48: return "B";
    case 51: return "T";
    case 0: return "oo";
    case 26: return "OO";
    case 1: return "n";
    case 2: return "m";
    case 3: return "g";
    case 4: return "a";
    case 5: return "k";
    case 6: return "s";
    case 7: return "d";
    case 8: return "oo";
    case 34: return "OO";
    case 9: return "h";
    case 10: return "b";
    case 11: return "l";
    case 12: return "p";
    case 13: return "t";
    case 14: return "e";
    case 15: return "b";
    case 16: return "ch";
    case 42: return "Ch";
    case 17: return "n";
    case 18: return "m";
    case 19: return "g";
    case 20: return  "ae";
    case 46: return  "Ae";
    case 21: return  "ts";
    case 47: return  "Ts";
    case 22: return "b";
    case 23: return  "bb";
    case 49: return  "Bb";
    case 24: return  "ee";
    case 50: return  "Ee";
    case 25: return "t";
    default: return sLetter;
    }
    return "";
}//end ConvertAbyssal

string ProcessAbyssal(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertAbyssal(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertCelestial(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "a";
    case 1: return "p";
    case 2: return "v";
    case 3: return "t";
    case 4: return "el";
    case 5: return "b";
    case 6: return "w";
    case 7: return "r";
    case 8: return "i";
    case 9: return "m";
    case 10: return "x";
    case 11: return "h";
    case 12: return "s";
    case 13: return "c";
    case 14: return "u";
    case 15: return "q";
    case 16: return "d";
    case 17: return "n";
    case 18: return "l";
    case 19: return "y";
    case 20: return "o";
    case 21: return "j";
    case 22: return "f";
    case 23: return "g";
    case 24: return "z";
    case 25: return "k";
    case 26: return "A";
    case 27: return "P";
    case 28: return "V";
    case 29: return "T";
    case 30: return "El";
    case 31: return "B";
    case 32: return "W";
    case 33: return "R";
    case 34: return "I";
    case 35: return "M";
    case 36: return "X";
    case 37: return "H";
    case 38: return "S";
    case 39: return "C";
    case 40: return "U";
    case 41: return "Q";
    case 42: return "D";
    case 43: return "N";
    case 44: return "L";
    case 45: return "Y";
    case 46: return "O";
    case 47: return "J";
    case 48: return "F";
    case 49: return "G";
    case 50: return "Z";
    case 51: return "K";
    default: return sLetter;
    }
    return "";
}//end ConvertCelestial

string ProcessCelestial(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertCelestial(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertGoblin(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "u";
    case 1: return "p";
    case 2: return "";
    case 3: return "t";
    case 4: return "'";
    case 5: return "v";
    case 6: return "k";
    case 7: return "r";
    case 8: return "o";
    case 9: return "z";
    case 10: return "g";
    case 11: return "m";
    case 12: return "s";
    case 13: return "";
    case 14: return "u";
    case 15: return "b";
    case 16: return "";
    case 17: return "n";
    case 18: return "k";
    case 19: return "d";
    case 20: return "u";
    case 21: return "";
    case 22: return "'";
    case 23: return "";
    case 24: return "o";
    case 25: return "w";
    case 26: return "U";
    case 27: return "P";
    case 28: return "";
    case 29: return "T";
    case 30: return "'";
    case 31: return "V";
    case 32: return "K";
    case 33: return "R";
    case 34: return "O";
    case 35: return "Z";
    case 36: return "G";
    case 37: return "M";
    case 38: return "S";
    case 39: return "";
    case 40: return "U";
    case 41: return "B";
    case 42: return "";
    case 43: return "N";
    case 44: return "K";
    case 45: return "D";
    case 46: return "U";
    case 47: return "";
    case 48: return "'";
    case 49: return "";
    case 50: return "O";
    case 51: return "W";
    default: return sLetter;
    }
    return "";
}//end ConvertGoblin

string ProcessGoblin(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertGoblin(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertDraconic(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "e";
    case 26: return "E";
    case 1: return "po";
    case 27: return "Po";
    case 2: return "st";
    case 28: return "St";
    case 3: return "ty";
    case 29: return "Ty";
    case 4: return "i";
    case 5: return "w";
    case 6: return "k";
    case 7: return "ni";
    case 33: return "Ni";
    case 8: return "un";
    case 34: return "Un";
    case 9: return "vi";
    case 35: return "Vi";
    case 10: return "go";
    case 36: return "Go";
    case 11: return "ch";
    case 37: return "Ch";
    case 12: return "li";
    case 38: return "Li";
    case 13: return "ra";
    case 39: return "Ra";
    case 14: return "y";
    case 15: return "ba";
    case 41: return "Ba";
    case 16: return "x";
    case 17: return "hu";
    case 43: return "Hu";
    case 18: return "my";
    case 44: return "My";
    case 19: return "dr";
    case 45: return "Dr";
    case 20: return "on";
    case 46: return "On";
    case 21: return "fi";
    case 47: return "Fi";
    case 22: return "zi";
    case 48: return "Zi";
    case 23: return "qu";
    case 49: return "Qu";
    case 24: return "an";
    case 50: return "An";
    case 25: return "ji";
    case 51: return "Ji";
    case 30: return "I";
    case 31: return "W";
    case 32: return "K";
    case 40: return "Y";
    case 42: return "X";
    default: return sLetter;
    }
    return "";
}//end ConvertDraconic

string ProcessDraconic(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertDraconic(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertDwarf(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "az";
    case 26: return "Az";
    case 1: return "po";
    case 27: return "Po";
    case 2: return "zi";
    case 28: return "Zi";
    case 3: return "t";
    case 4: return "a";
    case 5: return "wa";
    case 31: return "Wa";
    case 6: return "k";
    case 7: return "'";
    case 8: return "a";
    case 9: return "dr";
    case 35: return "Dr";
    case 10: return "g";
    case 11: return "n";
    case 12: return "l";
    case 13: return "r";
    case 14: return "ur";
    case 40: return "Ur";
    case 15: return "rh";
    case 41: return "Rh";
    case 16: return "k";
    case 17: return "h";
    case 18: return "th";
    case 44: return "Th";
    case 19: return "k";
    case 20: return "'";
    case 21: return "g";
    case 22: return "zh";
    case 48: return "Zh";
    case 23: return "q";
    case 24: return "o";
    case 25: return "j";
    case 29: return "T";
    case 30: return "A";
    case 32: return "K";
    case 33: return "'";
    case 34: return "A";
    case 36: return "G";
    case 37: return "N";
    case 38: return "L";
    case 39: return "R";
    case 42: return "K";
    case 43: return "H";
    case 45: return "K";
    case 46: return "'";
    case 47: return "G";
    case 49: return "Q";
    case 50: return "O";
    case 51: return "J";
    default: return sLetter; } return "";
}//end ConvertDwarf

string ProcessDwarf(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertDwarf(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertElven(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "il";
    case 26: return "Il";
    case 1: return "f";
    case 2: return "ny";
    case 28: return "Ny";
    case 3: return "w";
    case 4: return "a";
    case 5: return "o";
    case 6: return "v";
    case 7: return "ir";
    case 33: return "Ir";
    case 8: return "e";
    case 9: return "qu";
    case 35: return "Qu";
    case 10: return "n";
    case 11: return "c";
    case 12: return "s";
    case 13: return "l";
    case 14: return "e";
    case 15: return "ty";
    case 41: return "Ty";
    case 16: return "h";
    case 17: return "m";
    case 18: return "la";
    case 44: return "La";
    case 19: return "an";
    case 45: return "An";
    case 20: return "y";
    case 21: return "el";
    case 47: return "El";
    case 22: return "am";
    case 48: return "Am";
    case 23: return "'";
    case 24: return "a";
    case 25: return "j";

    case 27: return "F";
    case 29: return "W";
    case 30: return "A";
    case 31: return "O";
    case 32: return "V";
    case 34: return "E";
    case 36: return "N";
    case 37: return "C";
    case 38: return "S";
    case 39: return "L";
    case 40: return "E";
    case 42: return "H";
    case 43: return "M";
    case 46: return "Y";
    case 49: return "'";
    case 50: return "A";
    case 51: return "J";

    default: return sLetter; } return "";
}

string ProcessElven(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertElven(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertGnome(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
//cipher based on English -> Al Baed
    case 0: return "y";
    case 1: return "p";
    case 2: return "l";
    case 3: return "t";
    case 4: return "a";
    case 5: return "v";
    case 6: return "k";
    case 7: return "r";
    case 8: return "e";
    case 9: return "z";
    case 10: return "g";
    case 11: return "m";
    case 12: return "s";
    case 13: return "h";
    case 14: return "u";
    case 15: return "b";
    case 16: return "x";
    case 17: return "n";
    case 18: return "c";
    case 19: return "d";
    case 20: return "i";
    case 21: return "j";
    case 22: return "f";
    case 23: return "q";
    case 24: return "o";
    case 25: return "w";

    case 26: return "Y";
    case 27: return "P";
    case 28: return "L";
    case 29: return "T";
    case 30: return "A";
    case 31: return "V";
    case 32: return "K";
    case 33: return "R";
    case 34: return "E";
    case 35: return "Z";
    case 36: return "G";
    case 37: return "M";
    case 38: return "S";
    case 39: return "H";
    case 40: return "U";
    case 41: return "B";
    case 42: return "X";
    case 43: return "N";
    case 44: return "C";
    case 45: return "D";
    case 46: return "I";
    case 47: return "J";
    case 48: return "F";
    case 49: return "Q";
    case 50: return "O";
    case 51: return "W";
    default: return sLetter; } return "";
}

string ProcessGnome(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertGnome(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertHalfling(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
//cipher based on Al Baed -> English
    case 0: return "e";
    case 1: return "p";
    case 2: return "s";
    case 3: return "t";
    case 4: return "i";
    case 5: return "w";
    case 6: return "k";
    case 7: return "n";
    case 8: return "u";
    case 9: return "v";
    case 10: return "g";
    case 11: return "c";
    case 12: return "l";
    case 13: return "r";
    case 14: return "y";
    case 15: return "b";
    case 16: return "x";
    case 17: return "h";
    case 18: return "m";
    case 19: return "d";
    case 20: return "o";
    case 21: return "f";
    case 22: return "z";
    case 23: return "q";
    case 24: return "a";
    case 25: return "j";

    case 26: return "E";
    case 27: return "P";
    case 28: return "S";
    case 29: return "T";
    case 30: return "I";
    case 31: return "W";
    case 32: return "K";
    case 33: return "N";
    case 34: return "U";
    case 35: return "V";
    case 36: return "G";
    case 37: return "C";
    case 38: return "L";
    case 39: return "R";
    case 40: return "Y";
    case 41: return "B";
    case 42: return "X";
    case 43: return "H";
    case 44: return "M";
    case 45: return "D";
    case 46: return "O";
    case 47: return "F";
    case 48: return "Z";
    case 49: return "Q";
    case 50: return "A";
    case 51: return "J";
    default: return sLetter; } return "";
}

string ProcessHalfling(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertHalfling(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertOrc(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "ha";
    case 26: return "Ha";
    case 1: return "p";
    case 2: return "z";
    case 3: return "t";
    case 4: return "o";
    case 5: return "";
    case 6: return "k";
    case 7: return "r";
    case 8: return "a";
    case 9: return "m";
    case 10: return "g";
    case 11: return "h";
    case 12: return "r";
    case 13: return "k";
    case 14: return "u";
    case 15: return "b";
    case 16: return "k";
    case 17: return "h";
    case 18: return "g";
    case 19: return "n";
    case 20: return "";
    case 21: return "g";
    case 22: return "r";
    case 23: return "r";
    case 24: return "'";
    case 25: return "m";
    case 27: return "P";
    case 28: return "Z";
    case 29: return "T";
    case 30: return "O";
    case 31: return "";
    case 32: return "K";
    case 33: return "R";
    case 34: return "A";
    case 35: return "M";
    case 36: return "G";
    case 37: return "H";
    case 38: return "R";
    case 39: return "K";
    case 40: return "U";
    case 41: return "B";
    case 42: return "K";
    case 43: return "H";
    case 44: return "G";
    case 45: return "N";
    case 46: return "";
    case 47: return "G";
    case 48: return "R";
    case 49: return "R";
    case 50: return "'";
    case 51: return "M";
    default: return sLetter; } return "";
}

string ProcessOrc(string sPhrase)
{
    string sOutput, sLeft;
    int iToggle;
    while (GetStringLength(sPhrase) > 0)
    {
        sLeft = GetStringLeft(sPhrase,1);
        if ((sLeft == "*") || (sLeft == "<") || (sLeft == ">")) iToggle = abs(iToggle - 1);
        if (iToggle) sOutput = sOutput + sLeft;
        else sOutput = sOutput + ConvertOrc(sLeft);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}
