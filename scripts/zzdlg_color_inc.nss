// zzdlg_color_inc
//
// Copyright 2005-2006 by Greyhawk0
//
// Some colors and their names from html standard.

// Start tokens of intense colors (html)

const string txtRed =          "<c�  >";
const string txtLime =         "<c � >";
const string txtBlue =         "<c  �>";
const string txtYellow =       "<c�� >";
const string txtAqua =         "<c ��>";
const string txtFuchsia =      "<c� �>";

// Start tokens of less intense (html)
const string txtMaroon =       "<c�  >";
const string txtGreen =        "<c � >";
const string txtNavy =         "<c  �>";
const string txtOlive =        "<c�� >";
const string txtTeal =         "<c ��>";
const string txtPurple =       "<c� �>";

// Start tokens of shades of grey (html)
const string txtBlack =        "<c   >";
const string txtWhite =        "<c���>";
const string txtGrey =         "<c���>";
const string txtSilver =       "<c���>";

// Start tokens of misc. colors
const string txtOrange =       "<c�� >";
const string txtBrown =        "<c�**>";

// Adds token to change color.
//
// sText - Text to be colored.
// sColor - Color constant to use (all colors start with "txt").
string MakeTextColor( string sText, string sColor );
string MakeTextColor( string sText, string sColor )
{
    //if ( sColor != "" ) return ( sColor + sText + "</c>" );
    return sText;
}

