void main()
{
    object oTarget;

    // Get the creature who triggered this event.
    object oPC = GetLastUsedBy();

    // If the local int is exactly 1.
    if ( GetLocalInt(OBJECT_SELF, "play_sound") == 1 )
    {
        oTarget = GetObjectByTag("tt_sound_drum1");
        SoundObjectSetVolume(oTarget, 127);
        SoundObjectPlay(oTarget);
    }

    else if ( GetLocalInt(OBJECT_SELF, "play_sound") == 2 )
    {
        oTarget = GetObjectByTag("tt_sound_drum2");
        SoundObjectSetVolume(oTarget, 127);
        SoundObjectPlay(oTarget);
    }

    else if ( GetLocalInt(OBJECT_SELF, "play_sound") == 3 )
    {
        oTarget = GetObjectByTag("tt_sound_lute");
        SoundObjectSetVolume(oTarget, 127);
        SoundObjectPlay(oTarget);
    }

    else if ( GetLocalInt(OBJECT_SELF, "play_sound") == 4 )
    {
        oTarget = GetObjectByTag("tt_sound_piano");
        SoundObjectSetVolume(oTarget, 127);
        SoundObjectPlay(oTarget);
    }

    else if ( GetLocalInt(OBJECT_SELF, "play_sound") == 5 )
    {
        oTarget = GetObjectByTag("tt_sound_harp");
        SoundObjectSetVolume(oTarget, 127);
        SoundObjectPlay(oTarget);
    }
}

/*
    else
    {
        // Make changes to the sound object "tt_sound_lute1.
        oTarget = GetObjectByTag("tt_sound_harp");
        SoundObjectSetVolume(oTarget, 127);
        SoundObjectPlay(oTarget);
    }





/*
void main()
{
    object oTarget;

    // Get the creature who triggered this event.
    object oPC = GetLastUsedBy();

    // Make changes to the sound object "tt_sound_drum1.
    oTarget = GetObjectByTag("tt_sound_drum1");
    SoundObjectSetVolume(oTarget, 127);
    SoundObjectPlay(oTarget);
}
