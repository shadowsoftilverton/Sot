// NWNX Areas
// Area instancing plugin
// (c) by virusman, 2006-2010

// Create new area from ResRef.
object LoadArea(string sResRef);

// Create new area from ResRef.
object CreateArea(string sResRef);

// Destroy oArea.
void DestroyArea(object oArea);

// Set oArea's name to sName.
void SetAreaName(object oArea, string sName);

object LoadArea(string sResRef)
{
    SetLocalString(GetModule(), "NWNX!AREAS!CREATE_AREA", sResRef);
    return GetLocalObject(GetModule(), "NWNX!AREAS!GET_LAST_AREA_ID");
}

object CreateArea(string sResRef)
{
    return LoadArea(sResRef);
}

void DestroyArea(object oArea)
{
    SetLocalString(GetModule(), "NWNX!AREAS!DESTROY_AREA", ObjectToString(oArea));
}

void SetAreaName(object oArea, string sName)
{
    SetLocalString(oArea, "NWNX!AREAS!SET_AREA_NAME", sName);
}

