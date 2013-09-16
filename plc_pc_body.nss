#include "engine"

#include "inc_death"

void main()
{
    object oPC = GetLastUsedBy();
    object oSelf = OBJECT_SELF;

    // Just to piss you off, Invictus, in case you ever have to look at this. - Foxtrot
    string sGender = GetLocalInt(oSelf, BODY_VAR_GENDER) == GENDER_MALE
                   ? RESREF_BODY_MALE : RESREF_BODY_FEMALE;

    // Create our dummy copy, name it, then shuffle it to the real inventory as
    // a new object before destroying it.
    object oCopy = CreateItemOnObject(sGender, GetObjectByTag("server_body_storage"), 1);
    SetName(oCopy, GetLocalString(oSelf, BODY_VAR_NAME) + "'s Body");
    object oItem = CopyItem(oCopy, oPC);
    DestroyObject(oCopy);

    string sName = GetLocalString(oSelf, BODY_VAR_NAME);
    string sAccount = GetLocalString(oSelf, BODY_VAR_ACCOUNT);

    SetLocalString(oItem, BODY_VAR_NAME, sName);
    SetLocalString(oItem, BODY_VAR_ACCOUNT, sAccount);

    // Destroy our dummy placeable.
    SetIsDestroyable(TRUE);
    DestroyObject(oSelf);

    // Destroy our dummy model.
    object oModel = GetLocalObject(oSelf, BODY_VAR_MODEL);
    ExecuteScript("gen_destroy_self", oModel);
}
