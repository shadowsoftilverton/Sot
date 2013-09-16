//Created by 420 for the CEP
//Set color to 1 for cloak
//Based on script tlr_color1.nss by Stacy L. Ropella
void main()
{
    SetLocalInt(OBJECT_SELF, "ColorToDye", 1);

    ExecuteScript("tlr_dyecloak", OBJECT_SELF);
}
