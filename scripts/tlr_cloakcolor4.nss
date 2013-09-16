//Created by 420 for the CEP
//Set color to 4 for cloak
//Based on script tlr_color4.nss by Stacy L. Ropella
void main()
{
    SetLocalInt(OBJECT_SELF, "ColorToDye", 4);

    ExecuteScript("tlr_dyecloak", OBJECT_SELF);
}
