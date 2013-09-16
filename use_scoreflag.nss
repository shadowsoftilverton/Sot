void main()
{
    string msg = "";
    float delay = 0.0;

    object pc = GetFirstPC();
    while ( GetIsObjectValid(pc) ) {
        if ( GetLocalInt(pc, "CHESS_PARTICIPATED") ) {
            string msg = GetName(pc) + "(" + GetPCPlayerName(pc) + ")" + ": " + IntToString(GetLocalInt(pc, "CHESS_SCORE"));
            DelayCommand(delay, FloatingTextStringOnCreature(msg, GetLastUsedBy()));
            delay += 1.0;
        }

        pc = GetNextPC();
    }
}
