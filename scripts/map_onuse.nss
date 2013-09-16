#include "engine"

void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    int nRegion = GetLocalInt(oItem, "RegionMap");

    switch(nRegion)
    {
        case 1:   //Arabel City
            ExploreAreaForPlayer(GetObjectByTag("ara_east"), oUser, TRUE);
            ExploreAreaForPlayer(GetObjectByTag("ara_west"), oUser, TRUE);
            ExploreAreaForPlayer(GetObjectByTag("ara_northwest"), oUser, TRUE);
            ExploreAreaForPlayer(GetObjectByTag("ara_northeast"), oUser, TRUE);
            ExploreAreaForPlayer(GetObjectByTag("ara_southeast"), oUser, TRUE);
            ExploreAreaForPlayer(GetObjectByTag("ara_southwest"), oUser, TRUE);
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
    }
}
