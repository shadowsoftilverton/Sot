#include "engine"

#include "nwnx_events"

#include "zzdlg_tools_inc"

const int ENTRY_NUM = 1;

void main()
{
    _dlgDoSelection( _dlgGetPcSpeaker(), ENTRY_NUM - 1 );
}

