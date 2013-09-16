int StartingConditional()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
    if(GetGold(GetPCSpeaker()) >= iBet)
        return TRUE;

    return FALSE;
}
