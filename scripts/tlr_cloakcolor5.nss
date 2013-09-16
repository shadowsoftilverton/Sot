//Created by 420 for the CEP
//Set color to 5 for cloak
//Based on script tlr_color5.nss by Stacy L. Ropella
void main()
{
    SetLocalInt(OBJECT_SELF, "ColorToDye", 5);

    ExecuteScript("tlr_dyecloak", OBJECT_SELF);
}
