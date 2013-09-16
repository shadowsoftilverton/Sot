//Created by 420 for the CEP
//Set color to 7 for cloak
//Based on script tlr_color7.nss by Stacy L. Ropella
void main()
{
    SetLocalInt(OBJECT_SELF, "ColorToDye", 7);

    ExecuteScript("tlr_dyecloak", OBJECT_SELF);
}
