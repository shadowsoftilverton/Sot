int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(OBJECT_SELF, "nWhiteAssigned") == 0 &&
               GetLocalInt(OBJECT_SELF, "nBlackAssigned") == 0);
    return iResult;
}
