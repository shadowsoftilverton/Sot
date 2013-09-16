//Put this in onopen
//It will create an item of the resref similar to the chest/item tag after
//60 minutes, providing it is not already there.
//Quite handy for specific quest chests.

void main()
{

object oPC = GetLastOpenedBy();
int iRChance = GetLocalInt(OBJECT_SELF,"RCHANCE");

if (!GetIsPC(oPC)) return;

string iTag = GetTag(OBJECT_SELF);

if (GetItemPossessedBy(OBJECT_SELF, iTag)==OBJECT_INVALID)
    {
    if (GetLocalInt(OBJECT_SELF,"OpenedRecently")==0)
        {
        if (iRChance==0)
            {
            CreateItemOnObject(iTag, OBJECT_SELF);
            }
            else
            if (Random(100)<iRChance)
                {
                CreateItemOnObject(iTag, OBJECT_SELF);
                }
        }
    }
SetLocalInt(OBJECT_SELF, "OpenedRecently",1);
DelayCommand(3600.0, SetLocalInt(OBJECT_SELF, "OpenedRecently",0));
}
