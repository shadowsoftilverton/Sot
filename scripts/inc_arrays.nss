#include "engine"

int HEADER_SIZE = 1;

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//:: This is a reasonably simple array implementation using strings as a basis.
//:: It supports empty arrays and may be eventually adapted to have NWNX support
//:: which would allow it to store objects.
//::
//:: The structure is simple, with a short header containing the delimiter
//:: followed by the array itself. For all examples, '|' will be used as the
//:: delimiter (it is the default). For a first example, a properly formatted
//:: array with three elements would look as such, including the header:
//::
//:: ||a|b|c
//::
//:: This implementation should allow arrays to be used with simple data types
//:: without excessive strain on processing power.
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// DECLARATION

// STRING ARRAYS
//------------------------------------------------------------------------------

// Adds sElement to nIndex or the end of the array if nIndex is unspecified.
string AddArrayElement(string sArray, string sElement, int nIndex = -1);

// Gets the element at nIndex from sArray.
string GetArrayElement(string sArray, int nIndex);

// Returns a random element from sArray.
string GetRandomArrayElement(string sArray);

// Sets the element at nIndex to sElement.
string SetArrayElement(string sArray, string sElement, int nIndex);

// INT ARRAYS
//------------------------------------------------------------------------------

// Adds nInt to nIndex or the end of the array if nIndex is unspecified.
string AddArrayElement_int(string sArray, int nInt, int nIndex = -1);

// Gets the element at nIndex from sArray.
int GetArrayElement_int(string sArray, int nIndex);

// Returns a random element from sArray.
int GetRandomArrayElement_int(string sArray);

// Sets the element at nIndex to nInt.
string SetArrayElement_int(string sArray, int nInt, int nIndex);

// FLOAT ARRAYS
//------------------------------------------------------------------------------

// Adds fFloat to nIndex or the end of the array if nIndex is unspecified.
string AddArrayElement_float(string sArray, float fFloat, int nIndex = -1);

// Gets the element at nIndex from sArray.
float GetArrayElement_float(string sArray, int nIndex);

// Returns a random element from sArray.
float GetRandomArrayElement_float(string sArray);

// Sets the element at nIndex to fFloat.
string SetArrayElement_float(string sArray, float fFloat, int nIndex);

// OBJECT ARRAYS
//------------------------------------------------------------------------------

// Adds oObj to nIndex or the end of the array if nIndex is unspecified.
string AddArrayElement_object(string sArray, object oObj, int nIndex = -1);

// Gets the element at nIndex from sArray.
object GetArrayElement_object(string sArray, int nIndex);

// Returns a random element from sArray.
object GetRandomArrayElement_object(string sArray);

// Sets the element at nIndex to oObj.
string SetArrayElement_object(string sArray, object oObj, int nIndex);

// UNTYPED FUNCTIONS

// Returns a new array that uses sDelimiter to separate elements. Note that the
// delimiter must be a SINGLE character, no more or less, or the returned string
// will be empty.
// ================
// - sDelimiter: The character to separate elements of the array.
string Array(string sDelimiter="|");

// Removes the element at nIndex from sArray.
string RemoveArrayElement(string sArray, int nIndex);

// Returns the size of sArray.
int GetArraySize(string sArray);

// Gets the cursor index of nIndex, meaning its actual location in the string
// array.
int GetArrayCursorIndex(string sArray, int nIndex);

// Gets the delimiter of sArray.
string GetArrayDelimiter(string sArray);

// IMPLEMENTATION

string Array(string sDelimiter="|"){
    if(GetStringLength(sDelimiter) != 1) return "";

    return sDelimiter;
}

string SetArrayElement(string sArray, string sElement, int nIndex){
    string sReturn = RemoveArrayElement(sArray, nIndex);

    sReturn = AddArrayElement(sArray, sElement, nIndex);

    return sReturn;
}

string AddArrayElement(string sArray, string sElement, int nIndex = -1){
    string sDelimiter = GetArrayDelimiter(sArray);

    if(nIndex == -1){
        // If we're adding to the end of the array there's no need to make the
        // affair more complicated than need be.
        sArray += sDelimiter + sElement;
    } else {
        string sLeft;
        string sRight;

        int nCursor = GetArrayCursorIndex(sArray, nIndex);
        int nSize = GetStringLength(sArray);

        if(nCursor < 0) return sArray;

        sLeft = GetStringLeft(sArray, nCursor) + sDelimiter + sElement;
        sRight = GetSubString(sArray, nCursor, nSize - nCursor);

        sArray = sLeft + sRight;
    }

    return sArray;
}

string RemoveArrayElement(string sArray, int nIndex){
    string sDelimiter = GetArrayDelimiter(sArray);

    string sLeft;
    string sRight;

    int nCursor = GetArrayCursorIndex(sArray, nIndex);

    // Something went wrong.
    if(nCursor < 0) return sArray;

    // Get the left side.
    sLeft = GetStringLeft(sArray, nCursor);

    // Figure out where our element ends.
    nCursor = FindSubString(sArray, sDelimiter, nCursor + 1);

    // Get our right side.
    sRight = GetSubString(sArray, nCursor, GetStringLength(sArray) - nCursor);

    // Smoosh 'em together.
    sArray = sLeft + sRight;

    return sArray;
}

string GetArrayElement(string sArray, int nIndex){
    string sDelimiter = GetArrayDelimiter(sArray);

    int nCursor = GetArrayCursorIndex(sArray, nIndex);
    int nStart;

    // Something went wrong.
    if(nCursor < 0) return "";

    // Start is just ahead of nCursor.
    nStart = nCursor + 1;

    // Cursor jumps to next delimiter.
    nCursor = FindSubString(sArray, sDelimiter, nStart + 1);

    // Get our string.
    return GetSubString(sArray, nStart, nCursor - nStart);
}

int GetArraySize(string sArray){
    string sDelimiter = GetArrayDelimiter(sArray);

    int nCounter = 0;
    int nCursor = 0;

    // If the array is only as big as its header, its size 0.
    if(GetStringLength(sArray) == HEADER_SIZE) return 0;

    // Move the cursor to the element.
    for(;;){
        nCursor = FindSubString(sArray, sDelimiter, nCursor + 1);

        /// We're done if the cursor reaches the end.
        if(nCursor == -1) return nCounter;

        nCounter += 1;
    }

    return 1;
}

int GetArrayCursorIndex(string sArray, int nIndex){
    if(nIndex < 0) return -1;

    string sDelimiter = GetArrayDelimiter(sArray);

    int nCounter = 0;

    // Cursor should always start out after the header.
    int nCursor = HEADER_SIZE;

    // Move the cursor to the element.
    while(nCounter != nIndex){
        nCursor = FindSubString(sArray, sDelimiter, nCursor + 1);

        // Index must've been too high.
        if(nCursor == -1) return -1;

        nCounter += 1;
    }

    return nCursor;
}

string GetRandomArrayElement(string sArray){
    return GetArrayElement(sArray, Random(GetArraySize(sArray)));
}

string GetArrayDelimiter(string sArray){
    return GetSubString(sArray, 0, 1);
}

//------------------------------------------------------------------------------

string AddArrayElement_int(string sArray, int nInt, int nIndex = -1){
    return AddArrayElement(sArray, IntToString(nInt), nIndex);
}

int GetArrayElement_int(string sArray, int nIndex){
    return StringToInt(GetArrayElement(sArray, nIndex));
}

int GetRandomArrayElement_int(string sArray){
    return StringToInt(GetRandomArrayElement(sArray));
}

string SetArrayElement_int(string sArray, int nInt, int nIndex){
    return SetArrayElement(sArray, IntToString(nInt), nIndex);
}

//------------------------------------------------------------------------------

string AddArrayElement_float(string sArray, float fFloat, int nIndex = -1){
    return AddArrayElement(sArray, FloatToString(fFloat), nIndex);
}

float GetArrayElement_float(string sArray, int nIndex){
    return StringToFloat(GetArrayElement(sArray, nIndex));
}

float GetRandomArrayElement_float(string sArray){
    return StringToFloat(GetRandomArrayElement(sArray));
}

string SetArrayElement_float(string sArray, float fFloat, int nIndex){
    return SetArrayElement(sArray, FloatToString(fFloat), nIndex);
}

//------------------------------------------------------------------------------

string AddArrayElement_object(string sArray, object oObj, int nIndex = -1){
    return AddArrayElement(sArray, ObjectToString(oObj), nIndex);
}

object GetArrayElement_object(string sArray, int nIndex){
    return StringToObject(GetArrayElement(sArray, nIndex));
}

object GetRandomArrayElement_object(string sArray){
    return StringToObject(GetRandomArrayElement(sArray));
}

string SetArrayElement_object(string sArray, object oObj, int nIndex){
    return SetArrayElement(sArray, ObjectToString(oObj), nIndex);
}

////////////////////////////////////////////////////////////////////////////////


void SetFloatArray(object oObject, string sVarName, int nComponent, float fValue);
float GetFloatArray(object oObject, string sVarName, int nComponent);

void SetIntArray(object oObject, string sVarName, int nComponent, int nValue);
int GetIntArray(object oObject, string sVarName, int nComponent);

void SetLocationArray(object oObject, string sVarName, int nComponent, location lValue);
location GetLocationArray(object oObject, string sVarName, int nComponent);

void SetObjectArray(object oObject, string sVarName, int nComponent, object oValue);
object GetObjectArray(object oObject, string sVarName, int nComponent);

void SetStringArray(object oObject, string sVarName, int nComponent, string sValue);
string GetStringArray(object oObject, string sVarName, int nComponent);

/////////////////////////////

void SetFloatArray(object oObject, string sVarName, int nComponent, float fValue)
{
    SetLocalFloat(oObject, sVarName+IntToString(nComponent), fValue);
    return;
}

float GetFloatArray(object oObject, string sVarName, int nComponent)
{
    return GetLocalFloat(oObject, sVarName+IntToString(nComponent));
}

void SetIntArray(object oObject, string sVarName, int nComponent, int nValue)
{
    SetLocalInt(oObject, sVarName+IntToString(nComponent), nValue);
    return;
}

int GetIntArray(object oObject, string sVarName, int nComponent)
{
    return GetLocalInt(oObject, sVarName+IntToString(nComponent));
}

void SetLocationArray(object oObject, string sVarName, int nComponent, location lValue)
{
    SetLocalLocation(oObject, sVarName+IntToString(nComponent), lValue);
    return;
}

location GetLocationArray(object oObject, string sVarName, int nComponent)
{
    return GetLocalLocation(oObject, sVarName+IntToString(nComponent));
}

void SetObjectArray(object oObject, string sVarName, int nComponent, object oValue)
{
    SetLocalObject(oObject, sVarName+IntToString(nComponent), oValue);
    return;
}

object GetObjectArray(object oObject, string sVarName, int nComponent)
{
    return GetLocalObject(oObject, sVarName+IntToString(nComponent));
}

void SetStringArray(object oObject, string sVarName, int nComponent, string sValue)
{
    SetLocalString(oObject, sVarName+IntToString(nComponent), sValue);
    return;
}

string GetStringArray(object oObject, string sVarName, int nComponent)
{
    return GetLocalString(oObject, sVarName+IntToString(nComponent));
}

int GetLVArraySize_string(object oObject, string sVarName){
    int nCount = 0;

    string sContent = GetLocalString(oObject, sVarName + IntToString(nCount));

    while(sContent != ""){
        nCount += 1;

        sContent = GetLocalString(oObject, sVarName + IntToString(nCount));
    }

    return nCount;
}

