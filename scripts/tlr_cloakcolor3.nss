//Created by 420 for the CEP
//Set color to 3 for cloak
//Based on script tlr_color3.nss by Stacy L. Ropella
void main()
{
    SetLocalInt(OBJECT_SELF, "ColorToDye", 3);

    ExecuteScript("tlr_dyecloak", OBJECT_SELF);
}
