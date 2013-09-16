#include "engine"
#include "ave_d_inc"
//Written by Ave (2012/04/13)
//OnEnter Script for trigger around Orb
void main()
{
    object oSpirit=GetEnteringObject();
    if(GetTag(oSpirit)=="ave_spirit")
    {
        DelayCommand(0.1,SpiritChooseCorpse(oSpirit,GetLocation(oSpirit)));
    }
}
