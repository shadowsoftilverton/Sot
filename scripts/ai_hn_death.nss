//OnDeath script for horses
//Bt Hardcore UFO
//That's me. Hi.

void main()
{
    object oOwner = GetLocalObject(OBJECT_SELF, "HorseOwner");
    DeleteLocalObject(oOwner, "HorseActive");
}
