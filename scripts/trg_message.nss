//OnEnter trigger script by Hardcore UFO
//Players entering will get a message in one of two ways.
//
//Variables:
//enter_message             String      Message that will be sent to the entering player.
//enter_message_delivery    Int         If set to 1, the text will float overhead. Otherwise it will be a server message.

void main()
{
    object oCaller = OBJECT_SELF;
    object oEnter = GetEnteringObject();
    string sMessage = GetLocalString(oCaller, "enter_message");
    int nPop = GetLocalInt(oCaller, "enter_message_delivery");

    if(nPop == 1)
    {
        FloatingTextStringOnCreature(sMessage, oEnter, FALSE);
    }

    else
    {
        SendMessageToPC(oEnter, sMessage);
    }
}
