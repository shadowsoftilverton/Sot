//Created by 420 for the CEP
//Set color to 2 for cloak
//Based on script tlr_color2.nss by Stacy L. Ropella
void main()
{
    SetLocalInt(OBJECT_SELF, "ColorToDye", 2);

    ExecuteScript("tlr_dyecloak", OBJECT_SELF);
}
