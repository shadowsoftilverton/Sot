void NewWeaponUser(object oWeapon, object oUser)
{
    object oOld=GetLocalObject(oUser,"ave_wep_my");
    if(GetIsObjectValid(oOld)) SetLocalObject(oOld,"ave_wep_user",OBJECT_INVALID);//Their old weapon (if any) becomes an abandoned weapon
    SetLocalObject(oWeapon,"ave_wep_user",oUser);
    SetLocalObject(oUser,"ave_wep_my",oWeapon);
}

void main()
{
    object oPC=GetLastUsedBy();
    object oWeapon=OBJECT_SELF;
    object oUser=GetLocalObject(oWeapon,"ave_wep_user");
    if(oUser==oPC)
    {
        SendMessageToPC(oPC,"You are already using this ballistic weapon. Type '/wep ?' (without quotes) to get a list of ballistic weapon commands.");
        NewWeaponUser(oWeapon,oPC);
    }
    else
    {
        if(!GetIsObjectValid(oUser))
        {
            SendMessageToPC(oPC,"This ballistic weapon has been abandoned by its previous user. You are the new user. Type '/wep ?' (without quotes) to get a list of ballistic weapon commands.");
            NewWeaponUser(oWeapon,oPC);
        }
        else
        {
            float fDist=GetDistanceBetween(oUser,oWeapon);
            if(fDist>5.0|GetArea(oUser)!=GetArea(oWeapon))
            {
                SendMessageToPC(oPC,"The previous user has strayed too far from this ballistic weapon. You are the new user. Type '/wep ?' (without quotes) to get a list of ballistic weapon commands.");
                NewWeaponUser(oWeapon,oPC);
            }
        }
    }
}
