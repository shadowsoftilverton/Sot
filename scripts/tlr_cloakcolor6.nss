//Created by 420 for the CEP
//Set color to 6 for cloak
//Based on script tlr_color6.nss by Stacy L. Ropella
void main()
{
    SetLocalInt(OBJECT_SELF, "ColorToDye", 6);

    ExecuteScript("tlr_dyecloak", OBJECT_SELF);
}
