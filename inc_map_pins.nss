#include "aps_include"

//::////////////////////////////////////////////////////////////////////////:://
//:: DECLARATION                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

// Return iPinID of the first deleted map pin within the personal map pin array
int GetFirstDeletedMapPin(object oPC);

// Set a personal map pin on oPC. Returns iPinID.
// - fX: X coordinate of the pin. Defaults to the player's position.
// - fY: Y coordinate of the pin. Defaults to the player's position.
// - oArea: Area of the pin. Defaults to the player's area.
int SetMapPin(object oPC, string sPinText, float fX=-1.0, float fY=-1.0, object oArea=OBJECT_INVALID);

// Mark a map pin as deleted. Not a real delete to maintain the array
void DeleteMapPin(object oPC, int iPinID);

// Returns oArea from iPinID
object GetAreaOfMapPin(object oPC, int iPinID);

// Gives oPC their map pins from the database.
void GetMapPinsFromDB(object oPC);

// Saves the player's map pins.
void SaveMapPinsToDB(object oPC);

//::////////////////////////////////////////////////////////////////////////:://
//:: IMPLEMENTATION                                                         :://
//::////////////////////////////////////////////////////////////////////////:://

int GetFirstDeletedMapPin(object oPC)
{
   int i;
   int iPinID = 0;
   int iTotal = GetLocalInt(oPC, "NW_TOTAL_MAP_PINS");
   if(iTotal > 0) {
       for(i=1; i<=iTotal; i++) {
           if(GetLocalString(oPC, "NW_MAP_PIN_NTRY_" + IntToString(i)) == "DELETED") {
               iPinID = i;
               break;
           }
       }
   }
   return iPinID;
}

int SetMapPin(object oPC, string sPinText, float fX=-1.0, float fY=-1.0, object oArea=OBJECT_INVALID)
{
   // If oArea is not valid, we use the current area.
   if(oArea == OBJECT_INVALID) { oArea = GetArea(oPC); }
   // if fX and fY are both -1.0, we use the position of oPC
   if(fX == -1.0 && fY == -1.0) {
       vector vPos=GetPosition(oPC);
       fX = vPos.x;
       fY = vPos.y;
   }
   // Find out if we can reuse a deleted map pin
   int iUpdateDeleted = TRUE;
   int iPinID = 0;
   int iTotal = GetLocalInt(oPC, "NW_TOTAL_MAP_PINS");
   if(iTotal > 0) { iPinID = GetFirstDeletedMapPin(oPC); }
   // Otherwise use a new one
   if(iPinID == 0) { iPinID = iTotal + 1; iUpdateDeleted = FALSE; }
   // Set the pin
   string sPinID = IntToString(iPinID);
   SetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID, sPinText);
   SetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID, fX);
   SetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID, fY);
   SetLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID, oArea);
   if(!iUpdateDeleted) { SetLocalInt(oPC, "NW_TOTAL_MAP_PINS", iPinID); }
   return iPinID;
}

void DeleteMapPin(object oPC, int iPinID)
{
   string sPinID = IntToString(iPinID);
   // Only mark as deleted if set
   if(GetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID) != "") {
       SetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID, "DELETED");
       SetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID, 0.0);
       SetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID, 0.0);
       SetLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID, OBJECT_INVALID);
   }
}

object GetAreaOfMapPin(object oPC, int iPinID)
{
   return GetLocalObject(oPC, "NW_MAP_PIN_AREA_"+IntToString(iPinID));
}

void GetMapPinsFromDB(object oPC){
    // Right now this system is disabled!
    return;

    int nTotal = GetPersistentInt(oPC, "NW_TOTAL_MAP_PINS");

    string sPinID;
    string sEntry;
    string sArea;
    float fX, fY;

    int nIter;

    for(nIter=1; nIter <= nTotal; nIter++){
        sPinID  = IntToString(nIter);

        sEntry  = GetPersistentString(oPC, "NW_MAP_PIN_NTRY_" + IntToString(nIter), SQL_TABLE_MAP_PINS);
        fX      = GetPersistentFloat(oPC, "NW_MAP_PIN_XPOS_" + IntToString(nIter), SQL_TABLE_MAP_PINS);
        fY      = GetPersistentFloat(oPC, "NW_MAP_PIN_YPOS_" + IntToString(nIter), SQL_TABLE_MAP_PINS);
        sArea   = GetPersistentString(oPC, "NW_MAP_PIN_AREA_" + IntToString(nIter), SQL_TABLE_MAP_PINS);

        SetLocalString(oPC, "NW_MAP_PIN_NTRY_" + IntToString(nIter), sEntry);
        SetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + IntToString(nIter), fX);
        SetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + IntToString(nIter), fY);
        SetLocalObject(oPC, "NW_MAP_PIN_AREA_" + IntToString(nIter), GetObjectByTag(sArea));
    }

    SetLocalInt(oPC, "NW_TOTAL_MAP_PINS", nTotal);
}

void SaveMapPinsToDB(object oPC){
    // Right now this system is disabled!
    return;

    // Gets the total number of map pins.
    int nTotal = GetLocalInt(oPC, "NW_TOTAL_MAP_PINS");

    // Prime our variables for the loop.
    string sPinID;
    string sEntry;
    object oArea;
    float fX, fY;

    int nIter;
    int nOffset = 0;

    for(nIter=1; nIter <= nTotal; nIter++){
        sPinID  = IntToString(nIter);

        // Get our entry.
        sEntry  = GetLocalString(oPC, "NW_MAP_PIN_NTRY_" + IntToString(nIter));
        oArea   = GetLocalObject(oPC, "NW_MAP_PIN_AREA_" + IntToString(nIter));

        // If the entry isn't DELETED and the area it was created in is still
        // valid, save the entry. Otherwise, move the offset up one so that the
        // data is stored efficiently.
        if(sEntry != "DELETED" && GetIsObjectValid(oArea)){
            fX      = GetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + IntToString(nIter));
            fY      = GetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + IntToString(nIter));

            SetPersistentString(oPC, "NW_MAP_PIN_NTRY_" + IntToString(nIter - nOffset), sEntry, 0, SQL_TABLE_MAP_PINS);
            SetPersistentFloat(oPC, "NW_MAP_PIN_XPOS_" + IntToString(nIter - nOffset), fX, 0, SQL_TABLE_MAP_PINS);
            SetPersistentFloat(oPC, "NW_MAP_PIN_YPOS_" + IntToString(nIter - nOffset), fY, 0, SQL_TABLE_MAP_PINS);
            SetPersistentString(oPC, "NW_MAP_PIN_AREA_" + IntToString(nIter - nOffset), GetTag(oArea), 0, SQL_TABLE_MAP_PINS);
        } else {
            nOffset += 1;
        }
    }

    SetPersistentInt(oPC, "NW_TOTAL_MAP_PINS", nTotal - nOffset);
}

