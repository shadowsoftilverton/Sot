#include "engine"

void main()
{
    object oSpawn = GetObjectByTag("spn_guld_ball");

    if(oSpawn == OBJECT_INVALID)
    {
        object oPoint1 = GetObjectByTag("WP_SPN_BALL001");
        object oPoint2 = GetObjectByTag("WP_SPN_BALL002");
        location lPoint1 = GetLocation(oPoint1);
        location lPoint2 = GetLocation(oPoint2);

        CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_plc_magball", lPoint1, FALSE, "spn_guld_ball");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_plc_magball", lPoint2, FALSE, "spn_guld_ball");
    }
}
