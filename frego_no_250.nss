int StartingConditional()
{
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
    if(iBet > 0)
        return FALSE;

    return TRUE;
}
