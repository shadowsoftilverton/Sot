
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

