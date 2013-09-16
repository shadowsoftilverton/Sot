#include "chessinc"

void main()
{
    //ScoreWinner(GetLocalObject(OBJECT_SELF, "oWhitePlayer") == GetPCSpeaker() ? 1 : -1);

    ExecuteScript("destroygame", OBJECT_SELF);
}
