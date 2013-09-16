//Created by 420 for the CEP
//Set color to 0 for cloak
//Based on script tlr_color0.nss by Stacy L. Ropella
void main()
{
    SetLocalInt(OBJECT_SELF, "ColorToDye", 0);

    ExecuteScript("tlr_dyecloak", OBJECT_SELF);
}
